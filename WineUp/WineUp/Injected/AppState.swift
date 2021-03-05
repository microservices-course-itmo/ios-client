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
        var didLogin: Bool?
        var selectedTab = ApplicationMenuView.Tab.main
        var catalog = CatalogView.Routing()
        var favorites = FavoritesView.Routing()
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
