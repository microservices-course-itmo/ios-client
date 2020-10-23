//
//  CatalogView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation
import UIKit
import Combine

// MARK: - Variables & Init

extension CatalogView {
    final class ViewModel: ObservableObject {

        @Published var catalogItems: [CatalogView.RowItem] = []
        @Published var filtersBarItems: [CatalogFiltersBarView.Item] = []
        @Published var presentedFiltersBarItem: CatalogFiltersBarView.Item?
        @Published var searchText: String = ""

        init() {
            initWithMockData()
        }
    }

    struct RowItem: Identifiable, Equatable {
        var id = UUID()
        /// Title name of wine
        var title: String
        /// The country of manufacture
        var country: String
        /// Wine color (red/white/rose)
        var color: WineColor
        /// Wine astringency (dry/semi-dry/semi-sweet/sweet)
        var wineAstringency: WineAstringency
        /// Quantity of bottle in liters
        var quantityLiters: Float
        /// Is offer liked by the user
        var isLiked: Bool
        /// Compatibility percentage
        var chemistry: Float
        /// Title image of wine
        var titleImage: UIImage
        /// Retailer's logo
        var retailerImage: UIImage
        /// Rating of wine
        var rating: Float
        /// Price without discount in rub
        var originalPriceRub: Float
        /// Discount percentage
        var discountPercents: Float

        /// Price with discount in rub
        var priceWithDiscount: Float {
            return originalPriceRub * ((100 - discountPercents) / 100)
        }
    }
}

// MARK: - Public Methods

extension CatalogView.ViewModel {
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

    var wineAstringencyFilterViewModel: WineAstringencyFilter.ViewModel {
        .init()
    }

    var wineColorFilterViewModel: WineColorFilter.ViewModel {
        .init()
    }
}

// MARK: - Helpers

private extension CatalogView.ViewModel {
    func initWithMockData() {
        catalogItems = CatalogView.RowItem.mockedData
        filtersBarItems = CatalogFiltersBarView.Item.mockedData
    }
}
