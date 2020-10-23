//
//  ApplicationMenuView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation

// MARK: - ApplicationMenuView+ViewModel

extension ApplicationMenuView {
    final class ViewModel: ObservableObject {

        // MARK: - Public Methods
        var catalogRootViewModel: CatalogRootView.ViewModel {
            return .init()
        }
    }
}
