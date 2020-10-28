//
//  AppState.swift
//  WineUp
//
//  Created by Александр Пахомов on 27.10.2020.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var routing = Routing()
}

extension AppState {
    struct Routing: Equatable {
        var didLogin = false
        var selectedTab = ApplicationMenuView.Tab.main
        var catalogView = CatalogView.Routing()
        var favoritesView = FavoritesView.Routing()
    }
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        .init()
    }
}
#endif
