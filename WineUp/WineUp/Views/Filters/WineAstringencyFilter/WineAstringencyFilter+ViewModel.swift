//
//  WineAstringencyFilter+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 09.10.2020.
//

import Foundation

// MARK: - Variables & Init

extension WineAstringencyFilter {
    final class ViewModel: ObservableObject {

        @Published var items: [Item] = []
        @Published var checkedItems: [Item] = []

        init() {
            initStaticItems()
        }
    }

    struct Item: Equatable {
        var wineAstringency: WineAstringency
    }
}

// MARK: - Helpers

private extension WineAstringencyFilter.ViewModel {
    func initStaticItems() {
        items = [
            .init(wineAstringency: .dry),
            .init(wineAstringency: .semiDry),
            .init(wineAstringency: .semiSweet),
            .init(wineAstringency: .sweet)
        ]
    }
}
