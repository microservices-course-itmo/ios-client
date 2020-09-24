//
//  CatalogViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation

final class CatalogViewModel: ObservableObject {
    @Published var items: [CatalogItemModel]

    init(items: [CatalogItemModel]) {
        self.items = items
    }

    init() {
        self.items = []
    }
}
