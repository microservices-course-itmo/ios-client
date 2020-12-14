//
//  FirebaseService.swift
//  WineUp
//
//  Created by Александр Пахомов on 04.11.2020.
//

import Foundation
import Combine
import Firebase

typealias FirebaseToken = String
typealias PhoneVerificationId = String

protocol FirebaseService: Service {
    /// Sends SMS with verification code to phone number, publisher returns verificationId
    func sendVerificationCode(to phoneNumber: String) -> AnyPublisher<PhoneVerificationId, Error>
    /// Executes Firebase signIn method and returns token in publisher
    func submitVerificationCode(_ code: String, verificationId: PhoneVerificationId) -> AnyPublisher<FirebaseToken, Error>
    /// Retrieves the Firebase authentication token, possibly refreshing it if it has expired or if `force` flag is `true`
    func getToken(force: Bool) -> AnyPublisher<FirebaseToken, Error>
    /// Cleans firebase context
    func signOut() -> AnyPublisher<Void, Error>

    /// Current Firebase user
    var currentUser: User? { get }
    var isAuthenticated: Bool { get }
}

extension FirebaseService {
    /// Retrieves the Firebase authentication token, force refreshing it
    func getToken() -> AnyPublisher<FirebaseToken, Error> {
        getToken(force: false)
    }

    var isAuthenticated: Bool {
        currentUser != nil
    }
}

final class RealFirebaseService: FirebaseService {

    func sendVerificationCode(to phoneNumber: String) -> AnyPublisher<PhoneVerificationId, Error> {
        return Future<String, Error> { promise in
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                guard let verificationID = verificationID else { return }
                promise(.success(verificationID))
            }
        }.eraseToAnyPublisher()
    }

    func submitVerificationCode(_ code: String, verificationId: PhoneVerificationId) -> AnyPublisher<FirebaseToken, Error> {
        let credential = PhoneAuthProvider.provider()
            .credential(withVerificationID: verificationId,
                        verificationCode: code)

        return Future<String, Error> { promise in
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }

                guard let user = authResult?.user else {
                    promise(.failure(WineUpError.invalidState("Unable to extract user from successful auth result")))
                    return
                }

                user.getIDToken { token, error in
                    if let error = error {
                        promise(.failure(error))
                    }

                    guard let token = token else {
                        promise(.failure(WineUpError.invalidState("Unable to extract token from successful auth result")))
                        return
                    }

                    promise(.success(token))
                }
            }
        }.eraseToAnyPublisher()
    }

    func getToken(force: Bool) -> AnyPublisher<FirebaseToken, Error> {
        return Future<String, Error> { promise in
            guard let user = self.currentUser else {
                promise(.failure(WineUpError.invalidState("Unable to extract current firebase user")))
                return
            }

            user.getIDToken { token, error in
                if let error = error {
                    promise(.failure(error))
                }

                guard let token = token else {
                    promise(.failure(WineUpError.invalidState("Unable to extract token from successful auth result")))
                    return
                }

                promise(.success(token))
            }
        }.eraseToAnyPublisher()
    }

    func signOut() -> AnyPublisher<Void, Error> {
        do {
            try Auth.auth().signOut()
        } catch {
            return Fail<Void, Error>(error: error).eraseToAnyPublisher()
        }
        return Just<Void>.withErrorType(Error.self)
    }

    var currentUser: User? {
        Auth.auth().currentUser
    }
}

// MARK: - Preview

#if DEBUG
final class StubFirebaseService: FirebaseService {
    func sendVerificationCode(to phoneNumber: String) -> AnyPublisher<PhoneVerificationId, Error> {
        Just<PhoneVerificationId>.withErrorType("id", Error.self)
    }

    func submitVerificationCode(_ code: String, verificationId: PhoneVerificationId) -> AnyPublisher<FirebaseToken, Error> {
        Just<FirebaseToken>.withErrorType("token", Error.self)
    }

    func signOut() -> AnyPublisher<Void, Error> {
        Just<Void>.withErrorType(Error.self)
    }

    func getToken(force: Bool) -> AnyPublisher<FirebaseToken, Error> {
        Just<FirebaseToken>.withErrorType("token", Error.self)
    }

    var currentUser: User? {
        nil
    }

    static var preview: FirebaseService {
        StubFirebaseService()
    }
}
#endif
