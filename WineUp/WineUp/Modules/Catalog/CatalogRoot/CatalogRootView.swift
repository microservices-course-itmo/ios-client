//
//  CatalogRootView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

struct CatalogRootView: View {
    private static let testItems: [CatalogItemModel] = [
        CatalogItemModel(title: "1"),
        CatalogItemModel(title: "2")
    ]

    var body: some View {
        NavigationView {
            CatalogView(viewModel: CatalogViewModel(items: CatalogRootView.testItems))
                .navigationBarHidden(false)
                .navigationTitle("Catalog")
        }
    }
}
