//
//  PriceFilter+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 06.10.2020.
//

import Combine

// MARK: - PriceFilter+ViewModel

extension PriceFilter {
    final class ViewModel: ObservableObject {

        @Published var predefinedPrices: [PredefinedPriceInterval] = []
        @Published var showDiscountOffers: Bool = false
        @Published var selectedPredefinedPrice: PredefinedPriceInterval?

        init() {
            initStaticItems()
        }

        // MARK: - Public Methods

        func predefinedPriceIntervalDidTap(_ interval: PriceFilter.PredefinedPriceInterval) {
            assert(predefinedPrices.contains(interval))

            // If user taps on selected one
            if interval == selectedPredefinedPrice {
                selectedPredefinedPrice = nil
            } else {
                selectedPredefinedPrice = interval
            }
        }

        // MARK: - Helpers

        private func initStaticItems() {
            predefinedPrices = [
                .lessThan(maxPriceRub: 1_500),
                .between(minPriceRub: 1_500, maxPriceRub: 3_000),
                .between(minPriceRub: 3_000, maxPriceRub: 5_000),
                .between(minPriceRub: 5_000, maxPriceRub: 10_000),
                .greaterThan(minPriceRub: 10_000)
            ]
        }
    }
}

// MARK: - PriceFilter+PredefinedPriceInterval

extension PriceFilter {
    enum PredefinedPriceInterval: Identifiable, Hashable, Equatable {
        case lessThan(maxPriceRub: Int)
        case between(minPriceRub: Int, maxPriceRub: Int)
        case greaterThan(minPriceRub: Int)

        var id: Int {
            hashValue
        }

        var minPriceRub: Int? {
            switch self {
            case let .between(minPriceRub, _), let .greaterThan(minPriceRub):
                return minPriceRub
            default:
                return nil
            }
        }

        var maxPriceRub: Int? {
            switch self {
            case let .between(_, maxPriceRub), let .lessThan(maxPriceRub):
                return maxPriceRub
            default:
                return nil
            }
        }
    }
}
