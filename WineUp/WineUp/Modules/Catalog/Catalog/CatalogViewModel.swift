//
//  CatalogViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation

final class CatalogViewModel: ObservableObject {
    @Published var items: [CatalogItemModel]

    private static let testItems: [CatalogItemModel] = [
        CatalogItemModel(title: "Placeholder test"),
        CatalogItemModel(title: "test test test test"),
        CatalogItemModel(title: "test test test test"),
        CatalogItemModel(title: "test test test test")
    ]

    init() {
        self.items = CatalogViewModel.testItems
    }
}
