//
//  ApplicationMenuView.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.09.2020.
//

import SwiftUI

struct ApplicationMenuView: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        TabView {
            CatalogRootView(viewModel: viewModel.catalogRootViewModel)
                 .tabItem {
                     Image(systemName: "house.fill")
                     Text("Главное")
                 }
         CatalogRootView(viewModel: viewModel.catalogRootViewModel)
                 .tabItem {
                     Image(systemName: "book.fill")
                     Text("Каталог")
                 }
         CatalogRootView(viewModel: viewModel.catalogRootViewModel)
                 .tabItem {
                     Image(systemName: "star.fill")
                     Text("Избранное")
                 }
         CatalogRootView(viewModel: viewModel.catalogRootViewModel)
                 .tabItem {
                     Image(systemName: "person.fill")
                     Text("Профиль")
                 }
        }
    }
}

#if DEBUG
struct ApplicationMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationMenuView(viewModel: .init())
    }
}
#endif
