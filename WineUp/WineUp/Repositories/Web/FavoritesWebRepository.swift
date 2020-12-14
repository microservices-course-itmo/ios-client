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
    /// Get all favorite wine positions of current user
    func getAllFavoriteWinePositions() -> AnyPublisher<[FavoriteWinePositionJson], Error>
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

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func getUsersWithFavorite(by winePositionId: String) -> AnyPublisher<[UserJson], Error> {
        request(endpoint: .getUsersWithFavorite(by: winePositionId))
    }

    func getAllFavoriteWinePositions() -> AnyPublisher<[FavoriteWinePositionJson], Error> {
        request(endpoint: .getAllFavoriteWinePositions())
    }

    func addWinePositionToFavorites(by winePositionId: String) -> AnyPublisher<Void, Error> {
        call(endpoint: .addWinePositionToFavorites(by: winePositionId))
    }

    func deleteWinePositionFromFavorites(by winePositionId: String) -> AnyPublisher<Void, Error> {
        call(endpoint: .deleteWinePositionFromFavorites(by: winePositionId))
    }

    func clearFavorites() -> AnyPublisher<Void, Error> {
        call(endpoint: .clearFavorites())
    }
}

// MARK: - Helpers

private extension APICall {
    static func addWinePositionToFavorites(by winePositionId: String) -> APICall {
        APICall(path: "/favorites/\(winePositionId)", method: "POST", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func deleteWinePositionFromFavorites(by winePositionId: String) -> APICall {
        APICall(path: "/favorites/\(winePositionId)", method: "DELETE", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func clearFavorites() -> APICall {
        APICall(path: "/favorites/clear", method: "DELETE", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getAllFavoriteWinePositions() -> APICall {
        APICall(path: "/favorites", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getUsersWithFavorite(by winePositionId: String) -> APICall {
        APICall(path: "/favorites/\(winePositionId)/users", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }
}
