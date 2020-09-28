//
//  CatalogViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation

final class CatalogViewModel: ObservableObject {
    @Published var items: [CatalogItemModel]
    @Published var filtersBarItems: [CatalogFiltersBarItemModel]

    private static let testItems: [CatalogItemModel] = [
        CatalogItemModel(title: "1"),
        CatalogItemModel(title: "2")
    ]

    init() {
        self.items = CatalogViewModel.testItems
        self.filtersBarItems = [
            CatalogFiltersBarItemModel(title: "Рекомендованные"),
            CatalogFiltersBarItemModel(title: "Цена"),
            CatalogFiltersBarItemModel(title: "Страна"),
            CatalogFiltersBarItemModel(title: "Цвет"),
            CatalogFiltersBarItemModel(title: "Сахар")
        ]
    }

    func filterItemDidTap(_ item: CatalogFiltersBarItemModel) {

    }
}
