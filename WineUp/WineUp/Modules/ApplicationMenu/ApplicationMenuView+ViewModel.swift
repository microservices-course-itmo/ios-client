//
//  ApplicationMenuView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI
import Combine

// MARK: - ApplicationMenuView+ViewModel

extension ApplicationMenuView {
    final class ViewModel: ObservableObject {

        @Published var selectedTab: Tab = .main

        private let container: DIContainer
        private let cancelBag = CancelBag()

        init(container: DIContainer) {
            self.container = container

            container
                .appState.biAssign(\.routing.selectedTab, to: self, on: \.selectedTab, publisher: $selectedTab)
                .put(in: cancelBag)
        }

        // MARK: - Public Methods

        var loginViewModel: LoginView.ViewModel {
            .init(container: container)
        }

        var catalogRootViewModel: CatalogRootView.ViewModel {
            .init(container: container)
        }

        var favoritesRootViewModel: FavoritesRootView.ViewModel {
            .init(container: container)
        }
    }
}

// MARK: - ApplicationMenuView+Tab

extension ApplicationMenuView {
    enum Tab: Hashable {
        case main, catalog, favorites, profile
    }
}

// MARK: - Previews

#if DEBUG
extension ApplicationMenuView.ViewModel {
    static let preview = ApplicationMenuView.ViewModel(container: .preview)
}
#endif
