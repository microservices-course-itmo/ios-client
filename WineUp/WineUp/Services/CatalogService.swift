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
    func load(winePositions: LoadableSubject<[WinePosition]>)
}

// MARK: - Implementation

final class RealCatalogService: CatalogService {

    private let wineWebRepository: WineWebRepository
    private let shopWebRepository: ShopWebRepository
    private let winePositionWebRepository: WinePositionWebRepository

    init(
        wineWebRepository: WineWebRepository,
        winePositionWebRepository: WinePositionWebRepository,
        shopWebRepository: ShopWebRepository) {
        self.wineWebRepository = wineWebRepository
        self.winePositionWebRepository = winePositionWebRepository
        self.shopWebRepository = shopWebRepository
    }

    func load(winePositions: LoadableSubject<[WinePosition]>) {
        let bag = CancelBag()
        winePositions.wrappedValue.setIsLoading(cancelBag: bag)

        Publishers.Zip3(
            winePositionWebRepository.getAllWinePositions(),
            wineWebRepository.getAllWines(),
            shopWebRepository.getAllShops()
        )
        .eraseToAnyPublisher()
        .tryMap { winePositionsJson, winesJson, shopsJson in
            try RealCatalogService.fill(winePositions: winePositionsJson, wines: winesJson, shops: shopsJson)
        }
        .sinkToLoadable {
            winePositions.wrappedValue = $0
        }
        .store(in: bag)
    }

    private static func fill(winePositions: [WinePositionJson], wines: [WineJson], shops: [ShopJson]) throws -> [WinePosition] {
        var result: [WinePosition] = []
        for position in winePositions {
            guard let wine = wines.first(where: { $0.wineId == position.wineId }),
                  let shop = shops.first(where: { $0.id == position.shopId })
            else { continue }

            let winePosition = WinePosition(
                title: wine.name,
                country: "\(wine.regionId)", // Region needed
                color: wine.color.wineColor,
                year: "\(wine.year)",
                wineAstringency: wine.sugar.astringency,
                quantityLiters: -1, // Unknown
                isLiked: Bool.random(), // Unknown
                chemistry: -1, // Unknown
                titleImage: UIImage.checkmark, // Unknown
                retailerName: shop.site, // Name of shop needed
                rating: -1, // Unknown
                originalPriceRub: position.price,
                discountPercents: (position.price - position.actualPrice) / position.price
            )
            result.append(winePosition)
        }

        return result
    }
}
