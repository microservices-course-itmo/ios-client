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

        // MARK: - Public Methods

        var favoritesViewModel: FavoritesView.ViewModel {
            return .init()
        }
    }
}
