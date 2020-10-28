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
        private let container: DIContainer

        init(container: DIContainer) {
            self.container = container
        }
    }
}

// MARK: - Public Methods

extension ApplicationRootView.ViewModel {
    var applicationMenuViewModel: ApplicationMenuView.ViewModel {
        return .init(container: container)
    }
}

// MARK: - Previews

#if DEBUG
extension ApplicationRootView.ViewModel {
    static let preview = ApplicationRootView.ViewModel(container: .preview)
}
#endif
