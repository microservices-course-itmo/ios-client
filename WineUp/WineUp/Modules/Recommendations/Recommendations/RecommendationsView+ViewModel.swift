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

        @Published var recommendationsItems: Loadable<[WinePosition]> = .notRequested
        @Published var selectedRecommendationItemId: String?
        @Published var searchText: String = ""

        private let container: DIContainer
        private let cancelBag = CancelBag()

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.bind(\.routing.favorites.winePositionId, to: self, by: \.selectedRecommendationItemId)
                $selectedRecommendationItemId.bind(to: container.appState, by: \.value.routing.favorites.winePositionId)
                container.services.catalogService.favoritePositionsUpdate.sink(receiveValue: self.updateRecommendationPositions)
            }
        }

        // MARK: Public Methods

        func toggleLike(of winePosition: WinePosition) {
            guard var winePositions = recommendationsItems.value, let index = recommendationsItems.value?.firstIndex(of: winePosition) else {
                assertionFailure()
                return
            }
            winePositions[index].isLiked.toggle()

            let bag = CancelBag()
            recommendationsItems.setIsLoading(cancelBag: bag)
            container.services.catalogService
                .likeWinePosition(winePositionId: winePosition.id, like: !winePosition.isLiked)
                .map { _ in
                    winePositions
                }
                .sinkToLoadable(of: self, by: \.recommendationsItems)
                .store(in: bag)
        }

        func loadItems() {
            container.services.catalogService.load(favoriteWinePositions: loadableSubject(\.recommendationsItems))
        }

        func winePositionDetailsViewModelFor(_ winePosition: WinePosition) -> WinePositionDetailsView.ViewModel {
            .init(container: container, winePosition: winePosition)
        }

        // MARK: - Helpers

        private func updateRecommendationPositions() {
            loadItems()
        }
    }
}

#if DEBUG
extension RecommendationsView.ViewModel {
    static let preview = RecommendationsView.ViewModel(container: .preview)
}
#endif
