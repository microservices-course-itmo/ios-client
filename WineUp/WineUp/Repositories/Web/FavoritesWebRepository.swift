//
//  FavoritesWebRepository.swift
//  WineUp
//
//  Created by Александр Пахомов on 02.12.2020.
//

import Foundation
import Combine

// MARK: - FavoritesWebRepository

protocol FavoritesWebRepository: WebRepository {
    /// Add corresponding wine position to favorites
    func addWinePositionToFavorites(by winePositionId: String) -> AnyPublisher<Void, Error>
    /// Delete corresponding wine position from favorites
    func deleteWinePositionFromFavorites(by winePositionId: String) -> AnyPublisher<Void, Error>
    /// Delete all favorite wine positions
    func clearFavorites() -> AnyPublisher<Void, Error>
    /// Users with wine position in favorites
    func getUsersWithFavorite(by winePositionId: String) -> AnyPublisher<[UserJson], Error>
}

// MARK: - Implementation

final class RealFavoritesWebRepository: FavoritesWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let credentials: Store<Credentials?>

    init(session: URLSession, baseURL: String, credentials: Store<Credentials?>) {
        self.session = session
        self.baseURL = baseURL
        self.credentials = credentials
    }

    func getUsersWithFavorite(by winePositionId: String) -> AnyPublisher<[UserJson], Error> {
        accessTokenPublisher()
            .map { token in
                self.request(endpoint: .getUsersWithFavorite(by: winePositionId, accessToken: token))
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }

    func addWinePositionToFavorites(by winePositionId: String) -> AnyPublisher<Void, Error> {
        accessTokenPublisher()
            .map { token in
                self.call(endpoint: .addWinePositionToFavorites(by: winePositionId, accessToken: token))
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }

    func deleteWinePositionFromFavorites(by winePositionId: String) -> AnyPublisher<Void, Error> {
        accessTokenPublisher()
            .map { token in
                self.call(endpoint: .deleteWinePositionFromFavorites(by: winePositionId, accessToken: token))
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }

    func clearFavorites() -> AnyPublisher<Void, Error> {
        accessTokenPublisher()
            .map { token in
                self.call(endpoint: .clearFavorites(accessToken: token))
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}

// MARK: - Helpers

private extension APICall {
    static func addWinePositionToFavorites(by winePositionId: String, accessToken: AccessToken) -> APICall {
        APICall(path: "/favorites/\(winePositionId)", method: "POST", headers: HTTPHeaders.empty.accessToken(accessToken))
    }

    static func deleteWinePositionFromFavorites(by winePositionId: String, accessToken: AccessToken) -> APICall {
        APICall(path: "/favorites/\(winePositionId)", method: "DELETE", headers: HTTPHeaders.empty.accessToken(accessToken))
    }

    static func clearFavorites(accessToken: AccessToken) -> APICall {
        APICall(path: "/favorites/clear", method: "DELETE", headers: HTTPHeaders.empty.accessToken(accessToken))
    }

    static func getAllFavoriteWinePositions(accessToken: AccessToken) -> APICall {
        APICall(path: "/favorites/", method: "GET", headers: HTTPHeaders.empty.accessToken(accessToken))
    }

    static func getUsersWithFavorite(by winePositionId: String, accessToken: AccessToken) -> APICall {
        APICall(path: "/favorites/\(winePositionId)/users", method: "GET", headers: HTTPHeaders.empty.accessToken(accessToken))
    }
}
