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
    private var winePositions: [WinePosition]?
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

        if let cachedWinePositions = self.winePositions {
            winePositions.wrappedValue = .loaded(cachedWinePositions)
        }

        var filters: [WinePositionFilters] = []

        for (index, color) in colors.enumerated() {
            let filter = WinePositionFilters.value(.init(criterion: .color, operation: .equal, value: color.json.rawValue))
            filters.append(filter)
            if index < colors.count - 1 {
                filters.append(.separator(.or))
            }
        }

        filters.append(.separator(.and))

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

        winePositionWebRepository
            // TODO: подставлять параметры выбранные пользователем 
            .getAllTrueWinePositions(page: page, amount: amount, filters: filters, sortBy: sortBy)
            .map {
                self.transform(json: $0)
            }
            .pass {
                self.winePositions = $0
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
        // Ожидаемая реализация:
        // Сервис должен уметь кэшировать избранные винные позиции
        // Сервис должен хранить список избранных винных позиций и менять его при добавлении в избранное и удалении оттуда
        // Сервис должен вычислять `isLiked` поле у винной позиции, исходя из наличия её Id в сохранённом списке избранных
        // Для скачивания и модицикации списка избранных на сервере можно использовать FavoritesWebRepository
        // Для скачивания списка винных позиций по их Id можно использовать метод у TrueWinePositionWebRepository
        let bag = CancelBag()
        favoriteWinePositions.wrappedValue.setIsLoading(cancelBag: bag)

        winePositionWebRepository
            // TODO: реализуется в рамках https://trello.com/c/kvXh2k7m. Поправить этот код, когда будет реализовано.
            .getFavoritesTrueWinePositions()
            .map {
                self.transform(json: $0)
            }
            .sinkToLoadable {
                if case let .failed(error) = $0 {
                    print("Loading catalog error: \(error.description)")
                }

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
                isLiked: isLiked, // TODO: Missing data
                chemistry: Float.random(in: 0..<100), // TODO: Missing data
                titleImageUrl: json.image,
                retailerName: json.shop.site, // TODO: Missing data
                rating: Float.random(in: 0..<5), // TODO: Missing data
                originalPriceRub: json.price,
                discountPercents: (json.price - json.actualPrice) / json.price
            )
        }
    }
}

// MARK: - Helpers

private extension String {
    var base64Image: UIImage? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return UIImage(data: data)
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
