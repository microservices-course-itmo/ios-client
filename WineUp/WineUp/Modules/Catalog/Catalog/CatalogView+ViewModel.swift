//
//  CatalogView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation
import UIKit
import Combine

// MARK: - Variables & Init

extension CatalogView {
    final class ViewModel: ObservableObject {

        @Published var catalogItems: [CatalogView.Item] = []
        @Published var filtersBarItems: [CatalogFiltersBarView.Item] = []
        @Published var searchText: String = ""

        init() {
            initWithMockData()
        }
    }
}

// MARK: - Public Methods

extension CatalogView.ViewModel {
    func filterItemDidTap(_ item: CatalogFiltersBarView.Item) {

    }
}

// MARK: - Helpers

private extension CatalogView.ViewModel {
    func initWithMockData() {
        catalogItems = CatalogView.Item.mockedData
        filtersBarItems = CatalogFiltersBarView.Item.mockedData
    }
}
