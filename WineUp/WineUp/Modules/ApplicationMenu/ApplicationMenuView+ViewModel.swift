//
//  ApplicationMenuView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation

// MARK: - Variables & Init

extension ApplicationMenuView {
    final class ViewModel: ObservableObject {

    }
}

// MARK: - Public Methods

extension ApplicationMenuView.ViewModel {
    var catalogRootViewModel: CatalogRootView.ViewModel {
        return .init()
    }
}
