//
//  CatalogService.swift
//  WineUp
//
//  Created by Александр Пахомов on 17.11.2020.
//

import Foundation
import Combine
import UIKit

protocol CatalogService: Service {
    /// Fetch wine positions from server
    func load(winePositions: LoadableSubject<[WinePosition]>,
              page: Int,
              amount: Int,
              colors: [WineColor],
              sugars: [WineSugar],
              countries: [Country],
              sortBy: SortBy)
    /// Fetch favorite wine positions from server
    func load(favoriteWinePositions: LoadableSubject<[WinePosition]>)

    func removeWinePositionFromFavorites(winePositionId: String) -> AnyPublisher<Void, Error>

    func addWinePositionToFavorites(winePositionId: String) -> AnyPublisher<Void, Error>

    func clearFavorites() -> AnyPublisher<Void, Error>
}

// MARK: - Implementation

final class RealCatalogService: CatalogService {

    private let winePositionWebRepository: TrueWinePositionWebRepository
    private let favoritesWebRepository: FavoritesWebRepository
    private var favoritesId: Set<String>?

    init(winePositionWebRepository: TrueWinePositionWebRepository,
         favoritesWebRepository: FavoritesWebRepository) {
        self.winePositionWebRepository = winePositionWebRepository
        self.favoritesWebRepository = favoritesWebRepository
    }

    func load(winePositions: LoadableSubject<[WinePosition]>,
              page: Int,
              amount: Int,
              colors: [WineColor],
              sugars: [WineSugar],
              countries: [Country],
              sortBy: SortBy) {
        let bag = CancelBag()
        winePositions.wrappedValue.setIsLoading(cancelBag: bag)

        var filters: [WinePositionFilters] = []

        for (index, color) in colors.enumerated() {
            let filter = WinePositionFilters.value(.init(criterion: .color, operation: .equal, value: color.json.rawValue))
            filters.append(filter)
            if index < colors.count - 1 {
                filters.append(.separator(.or))
            }
        }

        // TODO: Refactor filters creation using reduce
        if !colors.isEmpty, !sugars.isEmpty {
            filters.append(.separator(.and))
        }

        for (index, sugar) in sugars.enumerated() {
            let filter = WinePositionFilters.value(.init(criterion: .sugar, operation: .equal, value: sugar.json.rawValue))
            filters.append(filter)
            if index < colors.count - 1 {
                filters.append(.separator(.or))
            }
        }

        // TODO: Country filter not implemented
//        filters.append(.separator(.and))

        // TODO: real sortBy needed
        let sortBy = FilterSortBy(attributeName: .actualPrice, order: .asc)

        updateFavoriteIds()
            .flatMap { _ in
                self.winePositionWebRepository
                    // TODO: подставлять параметры выбранные пользователем
                    .getAllTrueWinePositions(page: page, amount: amount, filters: filters, sortBy: sortBy)
            }
            .map {
                self.transform(json: $0)
            }
            .sinkToLoadable {
                if case let .failed(error) = $0 {
                    print("Loading catalog error: \(error.description)")
                }
                winePositions.wrappedValue = $0
            }
            .store(in: bag)
    }

    func load(favoriteWinePositions: LoadableSubject<[WinePosition]>) {
        let bag = CancelBag()
        favoriteWinePositions.wrappedValue.setIsLoading(cancelBag: bag)

        winePositionWebRepository
            .getFavoritesTrueWinePositions()
            .map {
                self.transform(json: $0)
            }
            .sinkToLoadable {
                favoriteWinePositions.wrappedValue = $0
            }
            .store(in: bag)
    }

    func addWinePositionToFavorites(winePositionId: String) -> AnyPublisher<Void, Error> {
        favoritesWebRepository
            .addWinePositionToFavorites(by: winePositionId)
            .pass {
                self.favoritesId?.insert(winePositionId)
            }
    }

    func removeWinePositionFromFavorites(winePositionId: String) -> AnyPublisher<Void, Error> {
        favoritesWebRepository
            .deleteWinePositionFromFavorites(by: winePositionId)
            .pass {
                self.favoritesId?.remove(winePositionId)
            }
    }

    func clearFavorites() -> AnyPublisher<Void, Error> {
        favoritesWebRepository.clearFavorites()
    }

    // MARK: - Private

    private func transform(json: [TrueWinePositionJson]) -> [WinePosition] {
        json.map { json in
            let wine = json.wine
            let isLiked = favoritesId?.contains(json.winePositionId) ?? false
            return WinePosition(
                id: json.winePositionId,
                title: json.wine.name,
                country: json.wine.region.first?.country ?? "Неизвестно",
                color: wine.color.wineColor,
                year: "\(wine.year)",
                wineSugar: wine.sugar.sugar,
                quantityLiters: json.volume,
                isLiked: isLiked,
                chemistry: Float.random(in: 0..<100), // TODO: Missing data
                titleImageUrl: json.image,
                retailerName: json.shop.site, // TODO: Missing data
                rating: Float.random(in: 0..<5), // TODO: Missing data
                originalPriceRub: json.price,
                discountPercents: json.discountPercents
            )
        }
    }

    private func favoritesIdPublisher() -> AnyPublisher<Set<String>, Error> {
        if let favoritesId = self.favoritesId {
            return Just(favoritesId)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return updateFavoriteIds()
    }

    private func updateFavoriteIds() -> AnyPublisher<Set<String>, Error> {
        favoritesWebRepository
            .getAllFavoriteWinePositions()
            .map { favoriteWinePositionJsons in
                Set(favoriteWinePositionJsons.map { $0.id })
            }
            .pass {
                self.favoritesId = $0
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Helpers

private extension String {
    var base64Image: UIImage? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return UIImage(data: data)
    }
}

private extension TrueWinePositionJson {
    var discountPercents: Float {
        guard price > 0 else { return 0 }
        return (price - actualPrice) / price
    }
}

// MARK: - Preview

#if DEBUG
final class StubCatalogService: CatalogService {
    func load(winePositions: LoadableSubject<[WinePosition]>,
              page: Int,
              amount: Int,
              colors: [WineColor],
              sugars: [WineSugar],
              countries: [Country],
              sortBy: SortBy) {
        winePositions.wrappedValue = .loaded(WinePosition.mockedData)
    }

    func load(favoriteWinePositions: LoadableSubject<[WinePosition]>) {
        favoriteWinePositions.wrappedValue = .loaded(WinePosition.mockedData)
    }

    func addWinePositionToFavorites(winePositionId: String) -> AnyPublisher<Void, Error> {
        Just<Void>.withErrorType(Error.self)
    }

    func removeWinePositionFromFavorites(winePositionId: String) -> AnyPublisher<Void, Error> {
        Just<Void>.withErrorType(Error.self)
    }

    func clearFavorites() -> AnyPublisher<Void, Error> {
        Just<Void>.withErrorType(Error.self)
    }

    static var preview: CatalogService {
        StubCatalogService()
    }
}
#endif
