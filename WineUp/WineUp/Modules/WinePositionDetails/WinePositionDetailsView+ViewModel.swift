//
//  WinePositionDetailsView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 29.10.2020.
//

import Foundation

// MARK: - WinePositionDetailsView+ViewModel

extension WinePositionDetailsView {
    final class ViewModel: ObservableObject {

        @Published var winePosition: WinePosition
        @Published var details: WinePosition.Details

        private let container: DIContainer
        private let cancelBag = CancelBag()

        init(container: DIContainer, winePosition: WinePosition) {
            self.container = container
            self.winePosition = winePosition
            self.details = winePosition.details
        }
    }
}

// MARK: - WinePosition+Details

extension WinePosition {
    struct Details: Equatable {
        var winePositionId: UUID
        var tasteDescription: String
        var dishSuggestions: String
        var reviews: [Review]
        var suggestions: [WinePosition]
    }
}

extension WinePosition.Details {
    struct Review: Equatable {
        var reviewerFullName: String
        var rating: Float
        var review: String
        var timestamp: Date
    }
}
