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
        @Published var selectedFavoriteItemId: UUID?
        @Published var searchText: String = ""

        private let container: DIContainer
        private let cancelBag = CancelBag()

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.bind(\.routing.favorites.winePositionId, to: self, by: \.selectedFavoriteItemId)
                $selectedFavoriteItemId.bind(to: container.appState, by: \.value.routing.favorites.winePositionId)
            }

            initWithMockData()
        }

        // MARK: Public Methods

        func clearFavorites() {
            favoritesItems = []
        }

        var favoritesSortByViewModel: FavoritesSortByView.ViewModel {
            .init()
        }

        func winePositionDetailsViewModelFor(_ winePosition: WinePosition) -> WinePositionDetailsView.ViewModel {
            .init(container: container, winePosition: winePosition)
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
