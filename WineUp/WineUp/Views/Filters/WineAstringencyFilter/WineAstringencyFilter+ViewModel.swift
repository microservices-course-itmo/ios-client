//
//  WineSugarFilter+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 09.10.2020.
//

import Foundation

// MARK: - WineSugarFilter+ViewModel

extension WineSugarFilter {
    final class ViewModel: ObservableObject {

        @Published var items: [Item] = []
        @Published var checkedItems: [Item] = []

        init() {
            initStaticItems()
        }

        // MARK: - Helpers

        private func initStaticItems() {
            items = [
                .init(wineSugar: .dry),
                .init(wineSugar: .semiDry),
                .init(wineSugar: .semiSweet),
                .init(wineSugar: .sweet)
            ]
        }
    }
}

// MARK: - WineSugarFilter+Item

extension WineSugarFilter {
    struct Item: Equatable {
        var wineSugar: WineSugar
    }
}
