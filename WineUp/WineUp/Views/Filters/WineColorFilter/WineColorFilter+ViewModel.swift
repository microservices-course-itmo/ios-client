//
//  WineColorFilter+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 09.10.2020.
//

import Foundation

// MARK: - WineColorFilter+ViewModel

extension WineColorFilter {
    final class ViewModel: ObservableObject {

        @Published var items: [Item] = []
        @Published var checkedItems: [Item] = []

        init() {
            initStaticItems()
        }

        // MARK: - Helpers

        private func initStaticItems() {
            items = [
                .init(wineColor: .white),
                .init(wineColor: .red),
                .init(wineColor: .rose)
            ]
        }
    }
}

// MARK: - WineColorFilter+Item

extension WineColorFilter {
    struct Item: Equatable {
        var wineColor: WineColor
    }
}
