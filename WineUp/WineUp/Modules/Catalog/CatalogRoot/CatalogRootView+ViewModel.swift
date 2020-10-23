//
//  CatalogRootViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation

// MARK: - CatalogRootView+ViewModel

extension CatalogRootView {
    final class ViewModel: ObservableObject {

        // MARK: - Public Methods

        var catalogViewModel: CatalogView.ViewModel {
            return .init()
        }
    }
}
