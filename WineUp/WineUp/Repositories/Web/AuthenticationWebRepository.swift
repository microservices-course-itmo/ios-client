//
//  AuthenticationWebRepository.swift
//  WineUp
//
//  Created by Александр Пахомов on 14.11.2020.
//

import Foundation
import Combine

typealias RefreshToken = String
typealias AccessToken = String

protocol AuthenticationWebRepository: WebRepository {
    /// Login user with LoginForm
    func login(with form: UserJson.LoginForm) -> AnyPublisher<UserJson.LoginResponse, Error>
    /// Refresh access token with refresh token
    func refresh(token: RefreshToken) -> AnyPublisher<UserJson.LoginResponse, Error>
    /// Register new user with form
    func registration(with form: UserJson.RegistrationForm) -> AnyPublisher<UserJson.LoginResponse, Error>
}

extension AuthenticationWebRepository {
    /// Login user with firebase token
    func login(with token: FirebaseToken) -> AnyPublisher<UserJson.LoginResponse, Error> {
        login(with: .init(fireBaseToken: token))
    }
}

final class RealAuthenticationWebRepository: AuthenticationWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func login(with form: UserJson.LoginForm) -> AnyPublisher<UserJson.LoginResponse, Error> {
        request(endpoint: .createLogin(form))
    }

    func refresh(token: RefreshToken) -> AnyPublisher<UserJson.LoginResponse, Error> {
        request(endpoint: .createRefresh(token))
    }

    func registration(with form: UserJson.RegistrationForm) -> AnyPublisher<UserJson.LoginResponse, Error> {
        request(endpoint: .createRegistration(form))
    }
}

// MARK: - Helpers

private extension APICall {

    static func createLogin(_ form: UserJson.LoginForm) -> APICall {
        APICall(path: "/login", method: "POST", value: form, encodingStratagy: .useDefaultKeys)
    }

    static func createRefresh(_ token: RefreshToken) -> APICall {
        APICall(path: "/refresh", method: "POST", parameters: [("refreshToken", token)])
    }

    static func createRegistration(_ form: UserJson.RegistrationForm) -> APICall {
        APICall(path: "/registration", method: "POST", value: form, encodingStratagy: .useDefaultKeys)
    }
}
