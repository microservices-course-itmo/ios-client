//
//  UserWebRepository.swift
//  WineUp
//
//  Created by Влад on 15.11.2020.
//

import Foundation
import Combine

// MARK: UserWebRepository

protocol UserWebRepository: WebRepository {
    /// Find user by id
    func findUser(by id: String) -> AnyPublisher<UserJson, Error>
    /// Find current user info
    func findCurrentUserInfo() -> AnyPublisher<UserJson, Error>
    /// Patch current user
    func updateCurrentUser(with form: UserJson.UpdateForm) -> AnyPublisher<UserJson, Error>
}

// MARK: - Implementation

final class RealUserWebRepository: UserWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let credentials: Store<Credentials?>

    init(session: URLSession, baseURL: String, credentials: Store<Credentials?>) {
        self.session = session
        self.baseURL = baseURL
        self.credentials = credentials
    }

    func findUser(by id: String) -> AnyPublisher<UserJson, Error> {
        accessTokenPublisher()
            .flatMap {
                self.request(endpoint: APICall.findUser(by: id, accessToken: $0))
            }
            .eraseToAnyPublisher()
    }

    func findCurrentUserInfo() -> AnyPublisher<UserJson, Error> {
        accessTokenPublisher()
            .flatMap {
                self.request(endpoint: .findCurrentUserInfo(accessToken: $0))
            }
            .eraseToAnyPublisher()
    }

    func updateCurrentUser(with form: UserJson.UpdateForm) -> AnyPublisher<UserJson, Error> {
        accessTokenPublisher()
            .flatMap {
                self.request(endpoint: .updateCurrentUser(with: form, accessToken: $0))
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Helpers

private extension APICall {
    static func findUser(by id: String, accessToken: AccessToken) -> APICall {
        APICall(path: "/users/\(id)", method: "GET", headers: HTTPHeaders.empty.accessToken(accessToken))
    }

    static func findCurrentUserInfo(accessToken: AccessToken) -> APICall {
        APICall(path: "/users/me", method: "GET", headers: HTTPHeaders.empty.accessToken(accessToken))
    }

    static func updateCurrentUser(with form: UserJson.UpdateForm, accessToken: AccessToken) -> APICall {
        APICall(path: "/users/me",
                method: "PATCH",
                headers: HTTPHeaders.empty.accessToken(accessToken),
                value: form,
                encodingStratagy: .useDefaultKeys)
    }
}
