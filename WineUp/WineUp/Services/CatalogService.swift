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

    private let winePositionWebRepository: TrueWinePositionWebRepository
    private var winePositions: [WinePosition]?

    init(winePositionWebRepository: TrueWinePositionWebRepository) {
        self.winePositionWebRepository = winePositionWebRepository
    }

    func load(winePositions: LoadableSubject<[WinePosition]>) {
        let bag = CancelBag()
        winePositions.wrappedValue.setIsLoading(cancelBag: bag)

        if let cachedWinePositions = self.winePositions {
            winePositions.wrappedValue = .loaded(cachedWinePositions)
        }

        let filters: [WinePositionFilters] =
            [.value(.init(criterion: .price, operation: .more, value: "100"))]

        winePositionWebRepository
            // TODO: подставлять параметры выбранные пользователем 
            .getAllTrueWinePositions(from: 0, to: 5, filters: filters, sortBy: [.init(attribute_name: .avg, order: .desc)])
            .map {
                self.transform(json: $0)
            }
            .pass {
                self.winePositions = $0
            }
            .sinkToLoadable {
                winePositions.wrappedValue = $0
            }
            .store(in: bag)
    }

    private func transform(json: [TrueWinePositionJson]) -> [WinePosition] {
        json.map { json in
            let wine = json.wine
            return WinePosition(
                id: json.winePositionId,
                title: json.wine.name,
                country: json.wine.region.first?.country ?? "Неизвестно",
                color: wine.color.wineColor,
                year: "\(wine.year)",
                wineSugar: wine.sugar.sugar,
                quantityLiters: json.volume,
                isLiked: Bool.random(), // TODO: Missing data
                chemistry: Float.random(in: 0..<100), // TODO: Missing data
                titleImage: json.image.base64Image ?? .add, // TODO: Missing OnNil action
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
    func load(winePositions: LoadableSubject<[WinePosition]>) {
        winePositions.wrappedValue = .loaded(WinePosition.mockedData)
    }

    static var preview: CatalogService {
        StubCatalogService()
    }
}
#endif
