//
//  ApplicationMenuView.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.09.2020.
//

import SwiftUI

struct ApplicationMenuView: View {

    @ObservedObject private var popupPresenter = PopupPresenter()
    @ObservedObject private var viewModel = ViewModel()

    var body: some View {
        ZStack {
            TabView {
                CatalogRootView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Главное")
                    }
                CatalogRootView()
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("Каталог")
                    }
                CatalogRootView()
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Избранное")
                    }
                CatalogRootView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Профиль")
                    }
            }

            popupPresenter.popupView
        }.environmentObject(popupPresenter)
    }
}
