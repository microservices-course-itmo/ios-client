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

        @Published var catalogItems: [CatalogItemModel] = []
        @Published var filtersBarItems: [CatalogFiltersBarItemModel] = []
        @Published var searchText: String = ""

        init() {
            initWithMockData()
        }

        func filterItemDidTap(_ item: CatalogFiltersBarItemModel) {

        }

        // MARK: Private

        private func initWithMockData() {
            self.catalogItems = CatalogItemModel.mockedData
            self.filtersBarItems = CatalogFiltersBarItemModel.mockedData
        }
    }
}
