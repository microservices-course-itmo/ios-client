//
//  RecommendationFilter+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 06.10.2020.
//

import Foundation

// MARK: - RecommendationFilter+ViewModel

extension RecommendationFilter {
    final class ViewModel: ObservableObject {

        @Published var catalogSortOrderItems: [CatalogSortOrderItem] = []
        @Published var checkedCatalogSortOrderItem: CatalogSortOrderItem?

        init() {
            initStaticCatalogSortOrderItems()
        }

        // MARK: Helpers

        private func initStaticCatalogSortOrderItems() {
            catalogSortOrderItems = [
                .init(sortOrder: .recommended),
                .init(sortOrder: .baseedOnRating)
            ]
        }
    }
}

// MARK: - RecommendationFilter+CatalogSortOrderItem

extension RecommendationFilter {
    struct CatalogSortOrderItem: Equatable {
        var sortOrder: CatalogSortOrder
    }
}
