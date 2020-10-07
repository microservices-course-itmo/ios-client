//
//  RecommendationFilterList+ViewModel.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 04.10.2020.
//

import SwiftUI

// MARK: - Variables & Init

extension RecommendationFilter.ItemsList {

    final class ViewModel: ObservableObject {

        @Published var items: [Item] = []
        @Published var pickedItem: Item?

        init() {
            initStaticItems()
        }

        init(items: [Item]) {
            self.items = items
        }

        convenience init(orders: [CatalogSortOrder]) {
            self.init(items: orders.map({ Item(sortOrder: $0) }))
        }
    }
}

// MARK: - Public Methods

extension RecommendationFilter.ItemsList.ViewModel {
    typealias Item = RecommendationFilter.ItemsList.Item

    func didItemTapped(item: Item) {
        assert(items.contains(item))

        // User taps on selected value
        if pickedItem == item {
            pickedItem = nil
        } else {
            pickedItem = item
        }
    }
}

// MARK: - Helpers

private extension RecommendationFilter.ItemsList.ViewModel {
    func initStaticItems() {
        items = [
            Item(sortOrder: .recommended),
            Item(sortOrder: .baseedOnRating)
        ]
    }
}
