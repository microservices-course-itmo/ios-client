//
//  CatalogView.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let rootVStackSpacing: CGFloat = 0
}

private extension LocalizedStringKey {
    static let navigationTitle = LocalizedStringKey("Catalog")
}

// MARK: - View

/// Stack of filters and list of catalog offers
struct CatalogView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack(spacing: .rootVStackSpacing) {
            SearchBarView(text: $viewModel.searchText)

            CatalogFiltersBarView(items: viewModel.filtersBarItems) { item in
                viewModel.filterItemDidTap(item)
            }

            List(viewModel.catalogItems) { item in
                CatalogRowView(item: item)
            }
        }
        .navigationTitle(.navigationTitle)
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
        }
    }
}
#endif
