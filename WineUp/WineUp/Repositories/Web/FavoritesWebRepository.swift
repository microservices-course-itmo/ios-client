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
    func getAllFavoriteWinePositions() -> AnyPublisher<FavoriteWinePositionJson, Error>
    /// Add corresponding wine position to favorites
    func addWinePositionToFavorites(winePositionId: String) -> AnyPublisher<Void, Error>
    /// Delete corresponding wine position from favorites
    func deleteWinePositionFromFavorites(winePositionId: String) -> AnyPublisher<Void, Error>
    /// Delete all favorite wine positions
    func clearFavorites() -> AnyPublisher<Void, Error>
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

    func getAllFavoriteWinePositions() -> AnyPublisher<FavoriteWinePositionJson, Error> {
        Fail<FavoriteWinePositionJson, Error>(error: WineUpError.notImplemented())
            .eraseToAnyPublisher()
    }

    func addWinePositionToFavorites(winePositionId: String) -> AnyPublisher<Void, Error> {
        Fail<Void, Error>(error: WineUpError.notImplemented())
            .eraseToAnyPublisher()
    }

    func deleteWinePositionFromFavorites(winePositionId: String) -> AnyPublisher<Void, Error> {
        Fail<Void, Error>(error: WineUpError.notImplemented())
            .eraseToAnyPublisher()
    }

    func clearFavorites() -> AnyPublisher<Void, Error> {
        Fail<Void, Error>(error: WineUpError.notImplemented())
            .eraseToAnyPublisher()
    }
}

// MARK: - Helpers

private extension APICall {

}
