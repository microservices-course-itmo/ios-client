//
//  ProfileView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 31.10.2020.
//

import Foundation

// MARK: - ProfileView+ViewModel

extension ProfileView {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var logout: Loadable<Void> = .notRequested

        private let container: DIContainer

        // MARK: Public

        init(container: DIContainer) {
            self.container = container
        }

        var hexAPNSId: String? {
            UserDefaults.standard.data(forKey: "APNSID")?.hexString
        }

        func logoutButtonDidTap() {
            let bag = CancelBag()
            logout.setIsLoading(cancelBag: bag)
            container.services.authenticationService
                .clean()
                .pass { _ in
                    self.container.appState.value.routing.didLogin = .loaded(false)
                }
                .sinkToLoadable {
                    self.logout = $0
                }
                .store(in: bag)

        }
    }
}

// MARK: - Preview

#if DEBUG
extension ProfileView.ViewModel {
    static let preview = ProfileView.ViewModel(container: .preview)
}
#endif
