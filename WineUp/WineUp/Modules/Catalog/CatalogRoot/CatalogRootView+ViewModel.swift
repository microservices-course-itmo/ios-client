//
//  CatalogRootViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation

// MARK: - Variables & Init

extension CatalogRootView {
    final class ViewModel: ObservableObject {

    }
}

// MARK: - Public Methods

extension CatalogRootView.ViewModel {
    var catalogViewModel: CatalogView.ViewModel {
        return .init()
    }
}
