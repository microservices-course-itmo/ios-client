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
        var winePositionId: String?
    }
}

// MARK: - CatalogView+FiltersViewModel

extension CatalogView {
    final class FiltersViewModel: ObservableObject {

        @Published var color: [WineColor] = []
        @Published var sugar: [WineSugar] = []
        @Published var sortBy: SortBy = .basedOnRating
        @Published var countries: [Country] = []

        @Published var colorTemp: [WineColor] = []
        @Published var sugarTemp: [WineSugar] = []
        @Published var sortByTemp: SortBy = .basedOnRating
        @Published var countriesTemp: [Country] = []

        func commitFilters() {
            color = colorTemp
            sugar = sugarTemp
            countries = countriesTemp
            sortBy = sortByTemp
        }

        func restoreFilters() {
            colorTemp = color
            sugarTemp = sugar
            countriesTemp = countries
            sortByTemp = sortBy
        }
    }
}

// MARK: - CatalogView+ViewModel

extension CatalogView {
    final class ViewModel: ObservableObject {

        @Published var catalogItems: Loadable<[WinePosition]> = .notRequested
        @Published var selectedCatalogItemId: String?
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

            filtersBarItems = [
                .recomendation,
                .price,
                .country,
                .wineColor,
                .wineSugar
            ]
        }

        // MARK: Public Methods

        func loadCatalogItems(colors: [WineColor], sugar: [WineSugar], countries: [Country], sortBy: SortBy) {
            // TODO: Calculate page based on lazy loading of catalog list
            container.services.catalogService.load(
                winePositions: loadableSubject(\.catalogItems),
                page: 0,
                amount: 10,
                colors: colors,
                sugars: sugar,
                countries: countries,
                sortBy: sortBy
            )
        }

        func filterItemDidTap(_ item: CatalogFiltersBarView.Item) {
            assert(filtersBarItems.contains(item) && presentedFiltersBarItem == nil)
            presentedFiltersBarItem = item
        }

        func dismissFilterDidTap() {
            assert(presentedFiltersBarItem != nil)
            presentedFiltersBarItem = nil
        }

        func winePositionDetailsViewModelFor(_ winePosition: WinePosition) -> WinePositionDetailsView.ViewModel {
            .init(container: container, winePosition: winePosition)
        }
    }
}

#if DEBUG
extension CatalogView.ViewModel {
    static let preview = CatalogView.ViewModel(container: .preview)
}
#endif
