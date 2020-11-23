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

    init(winePositionWebRepository: TrueWinePositionWebRepository) {
        self.winePositionWebRepository = winePositionWebRepository
    }

    func load(winePositions: LoadableSubject<[WinePosition]>) {
        let bag = CancelBag()
        winePositions.wrappedValue.setIsLoading(cancelBag: bag)

        winePositionWebRepository
            .getAllTrueWinePositions()
            .map {
                self.transform(json: $0)
            }
            .sinkToLoadable {
                winePositions.wrappedValue = $0
            }
            .store(in: bag)
    }

    private func transform(json: [TrueWinePositionJson]) -> [WinePosition] {
        return WinePosition.mockedData
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
