//
//  CatalogView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation
import UIKit
import Combine

extension CatalogView {
    final class ViewModel: ObservableObject {

        // MARK: API

        @Published var catalogItems: [CatalogView.Item] = []
        @Published var filtersBarItems: [CatalogFiltersBarView.Item] = []
        @Published var searchText: String = ""

        init() {
            initWithMockData()
        }

        func filterItemDidTap(_ item: CatalogFiltersBarView.Item) {

        }

        // MARK: Private

        private func initWithMockData() {
            self.catalogItems = CatalogView.Item.mockedData
            self.filtersBarItems = CatalogFiltersBarView.Item.mockedData
        }
    }
}
