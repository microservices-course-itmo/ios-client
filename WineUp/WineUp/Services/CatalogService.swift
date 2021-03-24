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
    func load(with id: String) -> AnyPublisher<WinePosition?, Error>
    /// Fetch wine positions from server
    func load(winePositions: LoadableSubject<[WinePosition]>,
              page: Int,
              amount: Int,
              colors: [WineColor],
              sugars: [WineSugar],
              minPrice: Int?,
              maxPrice: Int?,
              countries: [Country],
              sortBy: SortBy)
    /// Fetch favorite wine positions from server
    func load(favoriteWinePositions: LoadableSubject<[WinePosition]>)

    func removeWinePositionFromFavorites(winePositionId: String) -> AnyPublisher<Void, Error>

    func addWinePositionToFavorites(winePositionId: String) -> AnyPublisher<Void, Error>

    func addAPNS(tokenId: String) -> AnyPublisher<Void, Error>

    func likeWinePosition(winePositionId: String, like: Bool) -> AnyPublisher<Void, Error>

    func clearFavorites() -> AnyPublisher<Void, Error>
    /// Allows to subscribe on favorite positions changes
    var favoritePositionsUpdate: PassthroughSubject<Void, Never> { get }
}

extension CatalogService {
    func likeWinePosition(winePositionId: String, like: Bool) -> AnyPublisher<Void, Error> {
        if like {
            return addWinePositionToFavorites(winePositionId: winePositionId)
        } else {
            return removeWinePositionFromFavorites(winePositionId: winePositionId)
        }
    }
}

// MARK: - Implementation

final class RealCatalogService: CatalogService {

    private let winePositionWebRepository: TrueWinePositionWebRepository
    private let favoritesWebRepository: FavoritesWebRepository
    private let tokenWebRepository: TokenWebRepository
    private(set) var favoritePositionsUpdate = PassthroughSubject<Void, Never>()

    init(winePositionWebRepository: TrueWinePositionWebRepository,
         favoritesWebRepository: FavoritesWebRepository,
         tokenWebRepository: TokenWebRepository) {
        self.winePositionWebRepository = winePositionWebRepository
        self.favoritesWebRepository = favoritesWebRepository
        self.tokenWebRepository = tokenWebRepository
    }

    func load(with id: String) -> AnyPublisher<WinePosition?, Error> {
        winePositionWebRepository.getTrueWinePositions(by: [id])
            .map {
                self.transform(json: $0, defaultIsLiked: false)
            }
            .map {
                $0.first
            }
            .eraseToAnyPublisher()
    }

    func load(winePositions: LoadableSubject<[WinePosition]>,
              page: Int,
              amount: Int,
              colors: [WineColor],
              sugars: [WineSugar],
              minPrice: Int?,
              maxPrice: Int?,
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

        for (index, sugar) in sugars.enumerated() {
            let filter = WinePositionFilters.value(.init(criterion: .sugar, operation: .equal, value: sugar.json.rawValue))
            filters.append(filter)
            if index < sugars.count - 1 {
                filters.append(.separator(.or))
            }
        }

        if let minPrice = minPrice {
            filters.append(.value(.init(criterion: .price, operation: .more, value: String(minPrice))))
        }

        if minPrice != nil, maxPrice != nil {
            filters.append(WinePositionFilters.separator(.and))
        }

        if let maxPrice = maxPrice {
            filters.append(.value(.init(criterion: .price, operation: .less, value: String(maxPrice))))
        }

        // TODO: Country filter not implemented on server side
//        filters.append(.separator(.and))

        // TODO: real sortBy needed
        let sortBy = FilterSortBy(attributeName: .actualPrice, order: .asc)

        self.winePositionWebRepository
            // TODO: подставлять параметры выбранные пользователем
            .getAllTrueWinePositions(page: page, amount: amount, filters: filters, sortBy: sortBy)
            .map {
                self.transform(json: $0, defaultIsLiked: false)
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
                self.transform(json: $0, defaultIsLiked: true)
            }
            .sinkToLoadable {
                favoriteWinePositions.wrappedValue = $0
            }
            .store(in: bag)
    }
    func addAPNS(tokenId: String) -> AnyPublisher<Void, Error> {
         tokenWebRepository
            .addAPNS(by: tokenId)
    }
    func addWinePositionToFavorites(winePositionId: String) -> AnyPublisher<Void, Error> {
        favoritesWebRepository
            .addWinePositionToFavorites(by: winePositionId)
            .pass {
                // Needed to notify CatalogView and FavoritesView
                self.favoritePositionsUpdate.send(())
            }
    }

    func removeWinePositionFromFavorites(winePositionId: String) -> AnyPublisher<Void, Error> {
        favoritesWebRepository
            .deleteWinePositionFromFavorites(by: winePositionId)
            .pass {
                // Needed to notify CatalogView and FavoritesView
                self.favoritePositionsUpdate.send(())
            }
    }

    func clearFavorites() -> AnyPublisher<Void, Error> {
        favoritesWebRepository.clearFavorites()
            .pass {
                self.favoritePositionsUpdate.send(())
            }
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private func transform(json: [TrueWinePositionJson], defaultIsLiked: Bool) -> [WinePosition] {
        json.map { json in
            let wine = json.wine
            let isLiked = json.isLiked ?? defaultIsLiked

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
        guard price > 0, actualPrice > 0 else { return 0 }
        return 100 * (price - actualPrice) / price
    }
}

// MARK: - Preview

#if DEBUG
final class StubCatalogService: CatalogService {
    var favoritePositionsUpdate = PassthroughSubject<Void, Never>()

    func load(with id: String) -> AnyPublisher<WinePosition?, Error> {
        Just<WinePosition?>(nil)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func load(winePositions: LoadableSubject<[WinePosition]>,
              page: Int,
              amount: Int,
              colors: [WineColor],
              sugars: [WineSugar],
              minPrice: Int?,
              maxPrice: Int?,
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
    func addAPNS(tokenId: String) -> AnyPublisher<Void, Error> {
        Just<Void>.withErrorType(Error.self)
    }

    static var preview: CatalogService {
        StubCatalogService()
    }
}
#endif
