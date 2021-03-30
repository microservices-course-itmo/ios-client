//
//  RecommendationsRootView+ViewModel.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 29.03.2021.
//

import Foundation

// MARK: - FavoritesRootView+ViewModel

extension RecommendationsRootView {
    final class ViewModel: ObservableObject {

        private let container: DIContainer

        init(container: DIContainer) {
            self.container = container
        }

        // MARK: - Public Methods

        var recommendationsViewModel: RecommendationsView.ViewModel {
            .init(container: container)
        }
    }
}

#if DEBUG
extension RecommendationsRootView.ViewModel {
    static let preview = RecommendationsRootView.ViewModel(container: .preview)
}
#endif
