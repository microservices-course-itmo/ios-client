//
//  AuthenticationService.swift
//  WineUp
//
//  Created by Александр Пахомов on 14.11.2020.
//

import Foundation
import Combine

protocol AuthenticationService: Service {
    /// Retrieves firebase token and performs /login request. Saves refresh token locally
    func login() -> AnyPublisher<Void, Error>
    /// Retrieves locally saved refresh token and refreshes access token using it
    func refreshSession() -> AnyPublisher<Void, Error>
    /// Cleans locally saved credentials
    func closeSession() -> AnyPublisher<Void, Error>
    /// Closes session and cleans firebase context
    func clean() -> AnyPublisher<Void, Error>
    /// Register new user and login
    func register(with form: UserJson.RegistrationForm) -> AnyPublisher<UserJson, Error>
    /// Currently authenticated user's headers
    var authHeaders: HTTPHeaders? { get }
}

// MARK: - Implementation

final class RealAuthenticationService: AuthenticationService {

    private let firebaseService: FirebaseService
    private let authWebRepository: AuthenticationWebRepository
    private let authCredentialsPersistanceRepository: AuthCredentialsPersistanceRepository

    init(firebaseService: FirebaseService,
         authWebRepository: AuthenticationWebRepository,
         authCredentialsPersistanceRepository: AuthCredentialsPersistanceRepository) {
        self.firebaseService = firebaseService
        self.authWebRepository = authWebRepository
        self.authCredentialsPersistanceRepository = authCredentialsPersistanceRepository
    }

    func login() -> AnyPublisher<Void, Error> {
        // Retrieve token from firebase, perform /login request and save new credentials
        Fail<Void, Error>(error: WineUpError.notImplemented())
            .eraseToAnyPublisher()
    }

    func refreshSession() -> AnyPublisher<Void, Error> {
        // Retreive and check credentials, perform /refresh request and update saved credentials
        Fail<Void, Error>(error: WineUpError.notImplemented())
            .eraseToAnyPublisher()
    }

    func closeSession() -> AnyPublisher<Void, Error> {
        // Remove credentials
        Fail<Void, Error>(error: WineUpError.notImplemented())
            .eraseToAnyPublisher()
    }

    func clean() -> AnyPublisher<Void, Error> {
        // Close session and sign out in firebase client
        Fail<Void, Error>(error: WineUpError.notImplemented())
            .eraseToAnyPublisher()
    }

    func register(with form: UserJson.RegistrationForm) -> AnyPublisher<UserJson, Error> {
        authWebRepository.registration(with: form)
            .map { loginResponse in
                self.saveCredentialsFrom(loginResponse: loginResponse)
                return loginResponse.user
            }
            .eraseToAnyPublisher()
    }

    var authHeaders: HTTPHeaders? {
        authCredentialsPersistanceRepository.credentials?.authHeaders
    }

    private func saveCredentialsFrom(loginResponse response: UserJson.LoginResponse) {
        let cred = Credentials(accessToken: response.accessToken, refreshToken: response.refreshToken)
        authCredentialsPersistanceRepository.credentials = cred
    }
}

// MARK: - Helpers

extension Credentials {
    var authHeaders: HTTPHeaders {
        HTTPHeaders.empty.accessToken(accessToken)
    }
}

// MARK: - Preview

#if DEBUG
final class StubAuthenticationService: AuthenticationService {
    func login() -> AnyPublisher<Void, Error> {
        Just<Void>.withErrorType(Error.self)
    }

    func refreshSession() -> AnyPublisher<Void, Error> {
        Just<Void>.withErrorType(Error.self)
    }

    func closeSession() -> AnyPublisher<Void, Error> {
        Just<Void>.withErrorType(Error.self)
    }

    func clean() -> AnyPublisher<Void, Error> {
        Just<Void>.withErrorType(Error.self)
    }

    func register(with form: UserJson.RegistrationForm) -> AnyPublisher<UserJson, Error> {
        Just<UserJson>.withErrorType(UserJson.mockedData[0], Error.self)
    }

    var authHeaders: HTTPHeaders? {
        nil
    }

    static var preview: AuthenticationService {
        StubAuthenticationService()
    }
}
#endif
