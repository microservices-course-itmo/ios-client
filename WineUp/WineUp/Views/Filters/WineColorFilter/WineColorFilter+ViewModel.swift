//
//  WineColorFilter+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 09.10.2020.
//

import Foundation

// MARK: - Variables & Init

extension WineColorFilter {
    final class ViewModel: ObservableObject {

        @Published var items: [Item] = []
        @Published var checkedItems: [Item] = []

        init() {
            initStaticItems()
        }
    }

    struct Item: Equatable {
        var wineColor: WineColor
    }
}

// MARK: - Helpers

private extension WineColorFilter.ViewModel {
    func initStaticItems() {
        items = [
            .init(wineColor: .white),
            .init(wineColor: .red),
            .init(wineColor: .rose)
        ]
    }
}
