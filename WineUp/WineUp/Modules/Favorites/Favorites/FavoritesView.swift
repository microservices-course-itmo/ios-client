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
    @State private var showActionSheet = false

    // MARK: - UI

    var body: some View {
        VStack {
            SearchBarView(text: $viewModel.searchText)

            HStack {
                Button(action: sortByButtonDidTap) {
                    Text("Сортировать по")
                        .padding()
                }

                Spacer()

                Button(action: clearFavoritesButtonDidTap) {
                    Text("Очистить")
                        .padding()
                }
            }

            List(viewModel.favoritesItems) { item in
                FavoritesRowView(item: item)
            }
        }
        .actionSheet(isPresented: $showActionSheet, content: actionSheet)
        .navigationTitle(.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
    }

    private func actionSheet() -> ActionSheet {
        ActionSheet(
            title: Text("Очистить избранное"),
            message: Text("Вы уверены, что хотите очистить избранное?"),
            buttons: [
                .default(Text("Да"), action: clearFavoritesDidConfirm),
                .cancel(clearFavoritesDidCancel)
            ]
        )
    }

    // MARK: - Helpers

    private func sortByButtonDidTap() {

    }

    private func clearFavoritesButtonDidTap() {
        assert(!showActionSheet)
        showActionSheet = true
    }

    private func clearFavoritesDidConfirm() {
        showActionSheet = false
        viewModel.clearFavorites()
    }

    private func clearFavoritesDidCancel() {
        showActionSheet = false
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
