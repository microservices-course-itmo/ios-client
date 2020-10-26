//
//  ApplicationMenuView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

// MARK: - ApplicationMenuView+ViewModel

extension ApplicationMenuView {
    final class ViewModel: ObservableObject {

        // MARK: - Public Methods

        var loginViewModel: LoginView.ViewModel {
            .init()
        }

        var catalogRootViewModel: CatalogRootView.ViewModel {
            .init()
        }

        var favoritesRootViewModel: FavoritesRootView.ViewModel {
            .init()
        }
    }
}
