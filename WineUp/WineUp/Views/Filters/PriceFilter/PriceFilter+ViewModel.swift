//
//  PriceFilter+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 06.10.2020.
//

import Combine

// MARK: - Variables & Init

extension PriceFilter {
    final class ViewModel: ObservableObject {

        @Published var predefinedPrices: [PredefinedPriceInterval] = []
        @Published var minPriceRub: Float?
        @Published var maxPriceRub: Float?
        @Published var showDiscountOffers: Bool = false
        @Published var selectedPredefinedPrice: PredefinedPriceInterval?

        init() {
            initStaticItems()
        }
    }

    enum PredefinedPriceInterval: Identifiable, Hashable, Equatable {
        case lessThan(maxPriceRub: Float)
        case between(minPriceRub: Float, maxPriceRub: Float)
        case greaterThan(minPriceRub: Float)

        var id: Int {
            hashValue
        }
    }
}

// MARK: - Public Methods

extension PriceFilter.ViewModel {
    func predefinedPriceIntervalDidTap(_ interval: PriceFilter.PredefinedPriceInterval) {
        assert(predefinedPrices.contains(interval))

        // If user taps on selected one
        if interval == selectedPredefinedPrice {
            selectedPredefinedPrice = nil
        } else {
            selectedPredefinedPrice = interval
        }
    }
}

// MARK: - Helpers

private extension PriceFilter.ViewModel {
    func initStaticItems() {
        predefinedPrices = [
            .lessThan(maxPriceRub: 1_500),
            .between(minPriceRub: 1_500, maxPriceRub: 3_000),
            .between(minPriceRub: 3_000, maxPriceRub: 5_000),
            .between(minPriceRub: 5_000, maxPriceRub: 10_000),
            .greaterThan(minPriceRub: 10_000)
        ]
    }
}
