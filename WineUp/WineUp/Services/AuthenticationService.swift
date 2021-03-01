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
    func login() -> AnyPublisher<UserJson, Error>
    /// Retrieves locally saved refresh token and refreshes access token using it
    func refreshSession() -> AnyPublisher<UserJson, Error>
    /// Cleans locally saved credentials
    func closeSession() -> AnyPublisher<Void, Error>
    /// Closes session and cleans firebase context
    func clean() -> AnyPublisher<Void, Error>
    /// Register new user and login
    func register(with form: UserJson.RegistrationForm) -> AnyPublisher<UserJson, Error>
    /// Patch user data
    func updateCurrentUser(with form: UserJson.UpdateForm) -> AnyPublisher<UserJson, Error>
    /// Currently authenticated user's headers
    var authHeaders: HTTPHeaders? { get }
    /// Currently authenticated user
    var user: Store<UserJson?> { get }
}

// MARK: - Implementation

final class RealAuthenticationService: AuthenticationService {

    private let firebaseService: FirebaseService
    private let authWebRepository: AuthenticationWebRepository
    private let userRepository: UserWebRepository
    private let authCredentialsPersistanceRepository: AuthCredentialsPersistanceRepository
    private let credentials: Store<Credentials?>

    var user: Store<UserJson?> = .init(nil)

    init(firebaseService: FirebaseService,
         authWebRepository: AuthenticationWebRepository,
         userRepository: UserWebRepository,
         authCredentialsPersistanceRepository: AuthCredentialsPersistanceRepository,
         credentials: Store<Credentials?>) {
        self.firebaseService = firebaseService
        self.authWebRepository = authWebRepository
        self.userRepository = userRepository
        self.authCredentialsPersistanceRepository = authCredentialsPersistanceRepository
        self.credentials = credentials
    }

    func login() -> AnyPublisher<UserJson, Error> {
        // Retrieve token from firebase, perform /login request and save new credentials
        firebaseService
            .getToken()
            .flatMap { token in
                self.authWebRepository.login(with: token)
            }
            .map(handleLoginResponse(_:))
            .eraseToAnyPublisher()
    }

    func refreshSession() -> AnyPublisher<UserJson, Error> {
        // Retreive and check credentials, perform /refresh request and update saved credentials
        if let credentials = authCredentialsPersistanceRepository.credentials {
            return authWebRepository
                .refresh(token: credentials.refreshToken)
                .map(handleLoginResponse(_:))
                .eraseToAnyPublisher()
        } else {
            return Fail<UserJson, Error>(error: WineUpError.invalidAppState("Unable to extract credentials from persistance"))
                .eraseToAnyPublisher()
        }
    }

    func closeSession() -> AnyPublisher<Void, Error> {
        authCredentialsPersistanceRepository.credentials = nil
        credentials.value = nil
        user.value = nil
        return Just<Void>.withErrorType(Error.self).eraseToAnyPublisher()
    }

    func clean() -> AnyPublisher<Void, Error> {
        closeSession()
            .flatMap {
                self.firebaseService.signOut()
            }
            .eraseToAnyPublisher()
    }

    func register(with form: UserJson.RegistrationForm) -> AnyPublisher<UserJson, Error> {
        authWebRepository.registration(with: form)
            .map(handleLoginResponse(_:))
            .eraseToAnyPublisher()
    }

    // TODO: Should be moved to another service
    func updateCurrentUser(with form: UserJson.UpdateForm) -> AnyPublisher<UserJson, Error> {
        userRepository
            .updateCurrentUser(with: form)
            .pass {
                self.user.value = $0
            }
    }

    var authHeaders: HTTPHeaders? {
        authCredentialsPersistanceRepository.credentials?.authHeaders
    }

    private func handleLoginResponse(_ loginResponse: UserJson.LoginResponse) -> UserJson {
        saveCredentialsFrom(loginResponse: loginResponse)
        user.value = loginResponse.user
        return loginResponse.user
    }

    private func saveCredentialsFrom(loginResponse response: UserJson.LoginResponse) {
        let cred = Credentials(accessToken: response.accessToken, refreshToken: response.refreshToken)
        authCredentialsPersistanceRepository.credentials = cred
        credentials.value = cred
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
    func login() -> AnyPublisher<UserJson, Error> {
        Just<UserJson>.withErrorType(UserJson.mockedData[0], Error.self)
    }

    func refreshSession() -> AnyPublisher<UserJson, Error> {
        Just<UserJson>.withErrorType(UserJson.mockedData[0], Error.self)
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

    func updateCurrentUser(with form: UserJson.UpdateForm) -> AnyPublisher<UserJson, Error> {
        Just<UserJson>.withErrorType(UserJson.mockedData[0], Error.self)
    }

    var authHeaders: HTTPHeaders? {
        HTTPHeaders.empty.mockedAccessToken()
    }

    var user: Store<UserJson?> = .init(UserJson.mockedData[0])

    static var preview: AuthenticationService {
        StubAuthenticationService()
    }
}
#endif
