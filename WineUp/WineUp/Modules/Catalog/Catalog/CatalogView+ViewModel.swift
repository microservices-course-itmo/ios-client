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

        @Published var catalogItems: [WinePosition] = []
        @Published var selectedCatalogItemId: UUID?
        @Published var filtersBarItems: [CatalogFiltersBarView.Item] = []
        @Published var presentedFiltersBarItem: CatalogFiltersBarView.Item?
        @Published var searchText: String = ""

        private let container: DIContainer

        init(container: DIContainer) {
            self.container = container
            initWithMockData()
        }

        // MARK: Public Methods

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

        var wineAstringencyFilterViewModel: WineAstringencyFilter.ViewModel {
            .init()
        }

        var wineColorFilterViewModel: WineColorFilter.ViewModel {
            .init()
        }

        func winePositionDetailsViewModelFor(_ winePosition: WinePosition) -> WinePositionDetailsView.ViewModel {
            .init(container: container, winePosition: winePosition)
        }

        // MARK: Helpers

        private func initWithMockData() {
            catalogItems = WinePosition.mockedData
            filtersBarItems = CatalogFiltersBarView.Item.mockedData
        }
    }
}

#if DEBUG
extension CatalogView.ViewModel {
    static let preview = CatalogView.ViewModel(container: .preview)
}
#endif
