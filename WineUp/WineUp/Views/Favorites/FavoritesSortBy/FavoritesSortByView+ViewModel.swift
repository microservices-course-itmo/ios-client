//
//  FavoritesSortByView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 26.10.2020.
//

import Foundation

// MARK: - FavoritesSortByView+ViewModel

extension FavoritesSortByView {
    final class ViewModel: ObservableObject {

        @Published var sortByItems: [SortByItem] = []
        @Published var checkedSortByItems: SortByItem?

        init() {
            initStaticSortByItems()
        }

        // MARK: Helpers

        private func initStaticSortByItems() {
            sortByItems = [
                .init(sortBy: .recommended),
                .init(sortBy: .baseedOnRating),
                .init(sortBy: .priceAsc),
                .init(sortBy: .priceDesc)
            ]
        }
    }
}

// MARK: - FavoritesSortByView+SortByItem

extension FavoritesSortByView {
    struct SortByItem: Equatable {
        var sortBy: SortBy
    }
}
