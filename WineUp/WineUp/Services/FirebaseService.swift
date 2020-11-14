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

protocol FirebaseService {
    /// Sends SMS with verification code to phone number, publisher returns verificationId
    func sendVerificationCode(to phoneNumber: String) -> AnyPublisher<PhoneVerificationId, Error>
    /// Executes Firebase signIn method and returns token in publisher
    func submitVerificationCode(_ code: String, verificationId: PhoneVerificationId) -> AnyPublisher<FirebaseToken, Error>
    /// Retrieves the Firebase authentication token, possibly refreshing it if it has expired or if `force` flag is `true`
    func getToken(force: Bool) -> AnyPublisher<FirebaseToken, Error>

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

    func sendVerificationCode(to phoneNumber: String) -> AnyPublisher<String, Error> {
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

    func submitVerificationCode(_ code: String, verificationId: String) -> AnyPublisher<String, Error> {
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

    var currentUser: User? {
        Auth.auth().currentUser
    }
}
