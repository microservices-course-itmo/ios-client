//
//  ApplicationMenuView.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.09.2020.
//

import SwiftUI

struct ApplicationMenuView: View {
    @ObservedObject private var viewModel = ApplicationMenuViewModel()

    var body: some View {
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
    }
}
