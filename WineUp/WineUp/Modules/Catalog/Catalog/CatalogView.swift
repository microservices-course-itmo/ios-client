//
//  CatalogView.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.09.2020.
//

import SwiftUI

// MARK: - View

/// Stack of filters and list of catalog offers
struct CatalogView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 0) {
            SearchBarView(text: $viewModel.searchText)

            CatalogFiltersBarView(items: viewModel.filtersBarItems) { item in
                self.viewModel.filterItemDidTap(item)
            }

            List(viewModel.catalogItems) { item in
                CatalogRowView(item: item)
            }
        }
        .navigationTitle("Catalog")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CatalogView(viewModel: .init())
                .previewDevice("iPhone 11 Pro")
            CatalogView(viewModel: .init())
        }
    }
}
#endif
