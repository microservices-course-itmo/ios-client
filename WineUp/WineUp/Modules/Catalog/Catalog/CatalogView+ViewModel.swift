//
//  CatalogView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import UIKit
import Combine

// MARK: - CatalogView+Routing

extension CatalogView {
    struct Routing: Equatable {
        var winePositionId: UUID?
    }
}

// MARK: - CatalogView+ViewModel

extension CatalogView {
    final class ViewModel: ObservableObject {

        @Published var catalogItems: Loadable<[WinePosition]> = .notRequested
        @Published var selectedCatalogItemId: UUID?
        @Published var filtersBarItems: [CatalogFiltersBarView.Item] = []
        @Published var presentedFiltersBarItem: CatalogFiltersBarView.Item?
        @Published var searchText: String = ""

        private let container: DIContainer
        private let cancelBag = CancelBag()

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.bind(\.routing.catalog.winePositionId, to: self, by: \.selectedCatalogItemId)
                $selectedCatalogItemId.bind(to: container.appState, by: \.value.routing.catalog.winePositionId)
            }

            initStaticData()
        }

        // MARK: Public Methods

        func loadCatalogItems() {
            container.services.catalogService.load(winePositions: loadableSubject(\.catalogItems))
        }

        func filterItemDidTap(_ item: CatalogFiltersBarView.Item) {
            assert(filtersBarItems.contains(item) && presentedFiltersBarItem == nil)
            presentedFiltersBarItem = item
        }

        func dismissFilterDidTap() {
            assert(presentedFiltersBarItem != nil)
            presentedFiltersBarItem = nil
        }

        var recommendationFilterViewModel: RecommendationFilter.ViewModel {
            .init()
        }

        var priceFilterViewModel: PriceFilter.ViewModel {
            .init()
        }

        var countryFilterViewModel: CountryFilterView.ViewModel {
            .init()
        }

        var wineSugarFilterViewModel: WineSugarFilter.ViewModel {
            .init()
        }

        var wineColorFilterViewModel: WineColorFilter.ViewModel {
            .init()
        }

        func winePositionDetailsViewModelFor(_ winePosition: WinePosition) -> WinePositionDetailsView.ViewModel {
            .init(container: container, winePosition: winePosition)
        }

        // MARK: Helpers

        private func initStaticData() {
            filtersBarItems = [
                .recomendation,
                .price,
                .country,
                .wineColor,
                .wineSugar
            ]
        }
    }
}

#if DEBUG
extension CatalogView.ViewModel {
    static let preview = CatalogView.ViewModel(container: .preview)
}
#endif
