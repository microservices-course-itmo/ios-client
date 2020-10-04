//
//  RecommendationFilterList+ViewModel.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 04.10.2020.
//

import SwiftUI

// MARK: - RecommendationFilterList+ViewModel

extension RecommendationFilterList {

    class ViewModel: ObservableObject {

        // Properties
        @Published var variants: [Item]
        @Published var pickedItem: Item?

        // MARK: - Init

        init(variants: [String]) {
            self.variants = variants.map { Item(text: $0) }
        }

        // MARK: Public

        public func didItemTapped(item: Item) {
            guard pickedItem?.id != item.id else {
                pickedItem = nil
                return
            }
            self.pickedItem = item
        }
    }

    struct Item: Identifiable, Equatable {
        let id = UUID()
        let text: String
    }
}
