//
//  RecommendationsView+ViewModel.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 29.03.2021.
//

import UIKit
import Combine

// MARK: - Routing

extension RecommendationsView {
    struct Routing: Equatable {
        var winePositionId: String?
    }
}

// MARK: - FavoritesView+ViewModel

extension RecommendationsView {
    final class ViewModel: ObservableObject {

        @Published var recommendedWinePositions: Loadable<[WinePosition]> = .notRequested
        @Published var popularWinePositions: Loadable<[WinePosition]> = .notRequested
        private let container: DIContainer

        init(container: DIContainer) {
            self.container = container
        }

        // MARK: Public Methods

        func loadRecommended() {
            recommendedWinePositions = .loaded(WinePosition.mockedData)
        }

        func loadPopular() {
            popularWinePositions = .loaded(WinePosition.mockedData)
        }

        func winePositionDetailsViewModelFor(_ winePosition: WinePosition) -> WinePositionDetailsView.ViewModel {
            .init(container: container, winePosition: winePosition)
        }
    }
}

#if DEBUG
extension RecommendationsView.ViewModel {
    static let preview = RecommendationsView.ViewModel(container: .preview)
}
#endif
