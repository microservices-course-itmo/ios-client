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

        private let container: DIContainer

        // MARK: Public

        init(container: DIContainer) {
            self.container = container
        }

        func logoutButtonDidTap() {
            container.appState.value.routing.didLogin = false
        }
    }
}

// MARK: - Preview

#if DEBUG
extension ProfileView.ViewModel {
    static let preview = ProfileView.ViewModel(container: .preview)
}
#endif
