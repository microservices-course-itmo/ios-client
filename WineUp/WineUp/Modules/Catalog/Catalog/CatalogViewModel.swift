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
        CatalogItemModel(title: "1"),
        CatalogItemModel(title: "2")
    ]

    private var timer: Timer!
    private var counter = 3

    init() {
        self.items = CatalogViewModel.testItems
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { _ in
            self.items.append(CatalogItemModel(title: "\(self.counter)"))
            self.counter += 1
        })
    }
}
