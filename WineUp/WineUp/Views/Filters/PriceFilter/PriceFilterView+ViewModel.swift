//
//  PriceFilterView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 06.10.2020.
//

import Foundation

// MARK: - Variables & Init

extension PriceFilterView {
    final class ViewModel: ObservableObject {

        @Published var predefinedPrices: [Item] = []
        @Published var minPriceString: String = ""
        @Published var maxPriceString: String = ""
        @Published var showDiscountOffers: Bool = false
        @Published var selectedPredefinedPrice: Item?

        init() {
            initStaticItems()
        }
    }
}

// MARK: - Public Methods

extension PriceFilterView.ViewModel {
    func itemDidTap(_ item: PriceFilterView.Item) {
        assert(predefinedPrices.contains(item))

        // If user taps on selected one
        if item == selectedPredefinedPrice {
            selectedPredefinedPrice = nil
        } else {
            selectedPredefinedPrice = item
        }
    }
}

// MARK: - Helpers

private extension PriceFilterView.ViewModel {
    func initStaticItems() {
        predefinedPrices = [
            PriceFilterView.Item(title: "До 1500"),
            PriceFilterView.Item(title: "1500-3000"),
            PriceFilterView.Item(title: "3000-5000"),
            PriceFilterView.Item(title: "5000-10000"),
            PriceFilterView.Item(title: "Больше 1000")
        ]
    }
}
