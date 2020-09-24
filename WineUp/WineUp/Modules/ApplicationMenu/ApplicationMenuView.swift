//
//  ApplicationMenuView.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.09.2020.
//

import SwiftUI

struct ApplicationMenuView: View {
    var body: some View {
        TabView {
            CatalogRootView()
                .tabItem {
                    Text("Catalog")
                }
        }
    }
}
