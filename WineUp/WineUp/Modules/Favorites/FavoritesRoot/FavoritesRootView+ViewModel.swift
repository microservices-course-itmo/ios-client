//
//  FavoritesRootViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation

// MARK: - FavoritesRootView+ViewModel

extension FavoritesRootView {
    final class ViewModel: ObservableObject {

        private let container: DIContainer

        init(container: DIContainer) {
            self.container = container
        }

        // MARK: - Public Methods

        var favoritesViewModel: FavoritesView.ViewModel {
            .init(container: container)
        }
    }
}

#if DEBUG
extension FavoritesRootView.ViewModel {
    static let preview = FavoritesRootView.ViewModel(container: .preview)
}
#endif
