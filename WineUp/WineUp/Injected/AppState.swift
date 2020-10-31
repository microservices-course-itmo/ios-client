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
    var userData = UserData()
}

extension AppState {
    struct Routing: Equatable {
        var didLogin = true
        var selectedTab = ApplicationMenuView.Tab.main
        var catalogView = CatalogView.Routing()
        var favoritesView = FavoritesView.Routing()
    }
}

extension AppState {
    struct UserData: Equatable {
        var loginForm = LoginView.Form()
    }
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        .init()
    }
}
#endif
