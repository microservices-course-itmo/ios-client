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
        @Published var apnsSendRequest: Loadable<Void> = .notRequested

        private let container: DIContainer
        private let cancelBag = CancelBag()

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.bind(\.routing.selectedTab, to: self, by: \.selectedTab)
                $selectedTab.bind(to: container.appState, by: \.value.routing.selectedTab)
                NotificationsService.shared.$wineId.sink { [weak self] in
                    self?.loadWinePosition(with: $0)
                }
            }
        }

        // MARK: - Public Methods

        func addAPNS() {
            var hexAPNSId: String? {
                UserDefaults.standard.data(forKey: "APNSID")?.hexString
            }

            if hexAPNSId != nil {
                let bag = CancelBag()
                apnsSendRequest.setIsLoading(cancelBag: bag)
                container.services.catalogService.addAPNS(tokenId: hexAPNSId!)
                    .sinkToLoadable { self.apnsSendRequest = $0 }
                    .store(in: bag)
            } else {
                print("No APNS ID found")
            }
        }

        var recomendationsViewModel: RecommendationsRootView.ViewModel {
            .init(container: container)
        }

        var catalogRootViewModel: CatalogRootView.ViewModel {
            .init(container: container)
        }

        var favoritesRootViewModel: FavoritesRootView.ViewModel {
            .init(container: container)
        }

        var profileViewModel: ProfileView.ViewModel {
            .init(container: container)
        }

        func winePositionDetailsViewModel(for winePosition: WinePosition) -> WinePositionDetailsView.ViewModel {
            .init(container: container, winePosition: winePosition)
        }

        // MARK: - Private

        private func loadWinePosition(with id: String?) {
            guard let id = id else { return }
            container.services.catalogService
                .load(with: id)
                .sinkToResult { result in
                    switch result {
                    case .success(let pos):
                        self.winePosition = pos
                    case .failure(let error):
                        print("error:", error.localizedDescription)
                    }
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
