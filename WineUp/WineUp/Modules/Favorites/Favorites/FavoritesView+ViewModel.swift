//
//  FavoritesView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import UIKit
import Combine

// MARK: - Routing

extension FavoritesView {
    struct Routing: Equatable {
        var winePositionId: UUID?
    }
}

// MARK: - FavoritesView+ViewModel

extension FavoritesView {
    final class ViewModel: ObservableObject {

        @Published var favoritesItems: [WinePosition] = []
        @Published var searchText: String = ""

        private let container: DIContainer

        init(container: DIContainer) {
            self.container = container
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
            favoritesItems = WinePosition.mockedData
        }
    }
}

#if DEBUG
extension FavoritesView.ViewModel {
    static let preview = FavoritesView.ViewModel(container: .preview)
}
#endif
