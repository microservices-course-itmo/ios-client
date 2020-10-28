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

        @Published var showLogin = true

        private let container: DIContainer
        private let cancelBag = CancelBag()

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.map(\.routing.didLogin).toggle().bind(to: self, by: \.showLogin)
            }
        }
    }
}

// MARK: - Public Methods

extension ApplicationRootView.ViewModel {
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
