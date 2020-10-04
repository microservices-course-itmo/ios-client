//
//  CatalogViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation
import UIKit
import Combine

extension CatalogView {
    final class ViewModel: ObservableObject {
        @Published var items: [CatalogItemModel]
        @Published var filtersBarItems: [CatalogFiltersBarItemModel]
        @Published var searchText: String

        init() {
            self.items = CatalogItemModel.mockedData
            self.filtersBarItems = [
                CatalogFiltersBarItemModel(title: "Рекомендованные"),
                CatalogFiltersBarItemModel(title: "Цена"),
                CatalogFiltersBarItemModel(title: "Страна"),
                CatalogFiltersBarItemModel(title: "Цвет"),
                CatalogFiltersBarItemModel(title: "Сахар")
            ]
            self.searchText = ""
        }

        func filterItemDidTap(_ item: CatalogFiltersBarItemModel) {

        }
    }
}
