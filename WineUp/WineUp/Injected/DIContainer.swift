//
//  DIContainer.swift
//  WineUp
//
//  Created by Александр Пахомов on 28.10.2020.
//

import Foundation
import Combine

// MARK: - DIContainer

struct DIContainer {

    let appState: Store<AppState>
    let services: Services

    init(appState: Store<AppState>, services: DIContainer.Services) {
        self.appState = appState
        self.services = services
    }

    init(appState: AppState, services: DIContainer.Services) {
        self.init(appState: Store(appState), services: services)
    }
}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(appState: AppState.preview, services: .preview)
    }
}
#endif
