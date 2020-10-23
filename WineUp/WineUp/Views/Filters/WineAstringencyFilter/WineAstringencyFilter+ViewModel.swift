//
//  WineAstringencyFilter+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 09.10.2020.
//

import Foundation

// MARK: - WineAstringencyFilter+ViewModel

extension WineAstringencyFilter {
    final class ViewModel: ObservableObject {

        @Published var items: [Item] = []
        @Published var checkedItems: [Item] = []

        init() {
            initStaticItems()
        }

        // MARK: - Helpers

        private func initStaticItems() {
            items = [
                .init(wineAstringency: .dry),
                .init(wineAstringency: .semiDry),
                .init(wineAstringency: .semiSweet),
                .init(wineAstringency: .sweet)
            ]
        }
    }
}

// MARK: - WineAstringencyFilter+Item

extension WineAstringencyFilter {
    struct Item: Equatable {
        var wineAstringency: WineAstringency
    }
}
