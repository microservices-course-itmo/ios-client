//
//  ApplicationMenuView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

// MARK: - ApplicationMenuView+ViewModel

extension ApplicationMenuView {
    final class ViewModel: ObservableObject {

        @Published var selectedTab: Tab = .main
        @Published var winePosition: WinePosition?

        private let container: DIContainer
        private let cancelBag = CancelBag()

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.bind(\.routing.selectedTab, to: self, by: \.selectedTab)
                $selectedTab.bind(to: container.appState, by: \.value.routing.selectedTab)
            }

            NotificationsService.shared.$wineId.sink {
                self.loadWinePosition(with: $0)
            }.store(in: cancelBag)

            // эмулируем нажатие на уведомление и изменение переменной wineId сервиса через 2 секунды после запуска
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                NotificationsService.shared.wineId = "9355cf50-f669-4b40-9fe8-18ee4b46ed34"
            }
        }

        // MARK: - Public Methods

        var catalogRootViewModel: CatalogRootView.ViewModel {
            .init(container: container)
        }

        var favoritesRootViewModel: FavoritesRootView.ViewModel {
            .init(container: container)
        }

        var profileViewModel: ProfileView.ViewModel {
            .init(container: container)
        }

        var winePositionDetailsViewModel: WinePositionDetailsView.ViewModel? {
            guard let winePosition = winePosition else { return nil }
            return .init(container: container, winePosition: winePosition)
        }

        // MARK: - Private

        private func loadWinePosition(with id: String?) {
            guard let id = id else { return }
            container.services.catalogService.load(with: id)
                .sinkToResult { result in
                    // TODO: раскоментить, когда api будет работать
//                switch result {
//                case .success(let pos):
//                    self.winePosition = pos
//                case .failure(let error):
//                    print("error:", error.localizedDescription)
//                }
                // TODO: удалить, когда api заработает.
                    self.winePosition = WinePosition(id: id, title: "wineTitle", country: "country", color: .orange, year: "2012", wineSugar: .dry, quantityLiters: 0.5, isLiked: false, chemistry: 0.5, titleImageUrl: "", retailerName: "retailerName", rating: 0.3, originalPriceRub: 200, discountPercents: 10)
            }
            .store(in: cancelBag)
        }
    }
}

// MARK: - ApplicationMenuView+Tab

extension ApplicationMenuView {
    enum Tab: Hashable {
        case main, catalog, favorites, profile
    }
}

// MARK: - Previews

#if DEBUG
extension ApplicationMenuView.ViewModel {
    static let preview = ApplicationMenuView.ViewModel(container: .preview)
}
#endif
