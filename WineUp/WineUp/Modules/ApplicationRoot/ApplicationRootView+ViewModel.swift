//
//  ApplicationRootView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 22.09.2020.
//

import Foundation

// MARK: - ApplicationRootView+ViewModel

extension ApplicationRootView {
    final class ViewModel: ObservableObject {

        @Published var didLogin: Bool?
        @Published var showError503Screen: Bool = false

        private let container: DIContainer
        private let cancelBag = CancelBag()

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.updates(for: \.routing.didLogin).bind(to: self, by: \.didLogin)
                WebRepositoryState.shared.$error503.bind(to: self, by: \.showError503Screen)
            }
        }
    }
}

// MARK: - Public Methods

extension ApplicationRootView.ViewModel {

    func appDidLoad() {
        container.services.authenticationService
            .refreshSession()
            .sinkToResult { result in
                switch result {
                case let .failure(error):
                    print("Error refreshing session: \(error.description)")
                    self.container.appState.value.routing.didLogin = false
                case .success:
                    self.container.appState.value.routing.didLogin = true
                }
            }
            .store(in: cancelBag)
    }

    var loginViewModel: LoginView.ViewModel {
        .init(container: container)
    }

    var applicationMenuViewModel: ApplicationMenuView.ViewModel {
        .init(container: container)
    }
}

// MARK: - Previews

#if DEBUG
extension ApplicationRootView.ViewModel {
    static let preview = ApplicationRootView.ViewModel(container: .preview)
}
#endif
