//
//  CatalogView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import UIKit
import Combine

// MARK: - CatalogView+ViewModel

extension CatalogView {
    final class ViewModel: ObservableObject {

        @Published var catalogItems: [WinePosition] = []
        @Published var filtersBarItems: [CatalogFiltersBarView.Item] = []
        @Published var presentedFiltersBarItem: CatalogFiltersBarView.Item?
        @Published var searchText: String = ""

        init() {
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

        // MARK: Helpers

        private func initWithMockData() {
            catalogItems = WinePosition.mockedData
            filtersBarItems = CatalogFiltersBarView.Item.mockedData
        }
    }
}
