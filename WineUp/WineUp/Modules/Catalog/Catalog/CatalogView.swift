//
//  CatalogView.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.09.2020.
//

import SwiftUI

struct CatalogView: View {
    @ObservedObject private var viewModel = CatalogViewModel()
    @State var searchText: String

    var body: some View {
        VStack(spacing: 0.0) {
            SearchBarView(text: $searchText)
            Text(searchText)
            CatalogFiltersBarView(items: viewModel.filtersBarItems) { item in
                self.viewModel.filterItemDidTap(item)
            }
            List(viewModel.items) { item in
                CatalogRowView(item: item)
            }
        }
        .navigationBarHidden(false)
        .navigationTitle("Catalog")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CatalogView(searchText: "")
                .previewDevice("iPhone 11 Pro")
            CatalogView(searchText: "")
        }
    }
}
