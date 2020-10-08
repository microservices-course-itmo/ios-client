//
//  RecommendationFilter+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 06.10.2020.
//

import Foundation

// MARK: - Variables & Init

extension RecommendationFilter {
    final class ViewModel: ObservableObject {

        @Published var catalogSortOrderItems: [CatalogSortOrderItem] = []
        @Published var checkedCatalogSortOrderItem: CatalogSortOrderItem?

        init() {
            initStaticCatalogSortOrderItems()
        }
    }
}

extension RecommendationFilter {
    struct CatalogSortOrderItem: Equatable {
        var sortOrder: CatalogSortOrder
    }
}

// MARK: - Public Methods

extension RecommendationFilter.ViewModel {

}

// MARK: - Helpers

private extension RecommendationFilter.ViewModel {
    func initStaticCatalogSortOrderItems() {
        catalogSortOrderItems = [
            .init(sortOrder: .recommended),
            .init(sortOrder: .baseedOnRating)
        ]
    }
}
