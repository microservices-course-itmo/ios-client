//
//  FavoritesView.swift
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
    static let navigationTitle = LocalizedStringKey("Избранное")
}

// MARK: - View

/// Stack of filters and list of favorites wine positions
struct FavoritesView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack {
            SearchBarView(text: $viewModel.searchText)

            List(viewModel.favoritesItems) { item in
                FavoritesRowView(item: item)
            }
        }
        .navigationTitle(.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
    }
}

typealias FavoritesRowView = CatalogRowView

// MARK: - Preview

#if DEBUG
struct FavoritesView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            FavoritesView(viewModel: .init())
        }
    }
}
#endif
