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
}

// MARK: - Implementation

final class RealUserWebRepository: UserWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func findUser(by id: String) -> AnyPublisher<UserJson, Error> {
        request(endpoint: .findUser(by: id))
    }

    func findCurrentUserInfo() -> AnyPublisher<UserJson, Error> {
        request(endpoint: .findCurrentUserInfo())
    }
}

// MARK: - Helpers

private extension APICall {
    static func findUser(by id: String) -> APICall {
        APICall(path: "/users/\(id)", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func findCurrentUserInfo() -> APICall {
        APICall(path: "/users/me", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }
}
