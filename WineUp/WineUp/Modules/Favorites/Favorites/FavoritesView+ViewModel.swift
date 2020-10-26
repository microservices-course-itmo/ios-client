//
//  FavoritesView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import UIKit
import Combine

// MARK: - FavoritesView+ViewModel

extension FavoritesView {
    final class ViewModel: ObservableObject {

        @Published var favoritesItems: [FavoritesView.RowItem] = []
        @Published var searchText: String = ""

        init() {
            initWithMockData()
        }

        // MARK: Public Methods

        func clearFavorites() {
            favoritesItems = []
        }

        var favoritesSortByViewModel: FavoritesSortByView.ViewModel {
            .init()
        }

        // MARK: Helpers

        private func initWithMockData() {
            favoritesItems = RowItem.mockedData
        }
    }
}

// MARK: - FavoritesView+RowItem

extension FavoritesView {
    typealias RowItem = CatalogView.RowItem
}
