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
    @State private var showSortByView = false

    // MARK: - UI

    var body: some View {
        ZStack {
            content()

            if showSortByView {
                FavoritesSortByView(viewModel: viewModel.favoritesSortByViewModel)
                    .wrapped(onShouldDismiss: sortByViewShouldDismiss, onSubmit: sortByViewDidSubmit)
            }
        }
    }

    private func content() -> some View {
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
}

// MARK: - Helpers

typealias FavoritesRowView = CatalogRowView

private extension FavoritesView {
    func sortByButtonDidTap() {
        withAnimation(.defaultEaseInOut) {
            showSortByView = true
        }
    }

    func sortByViewShouldDismiss() {
        withAnimation(.defaultEaseInOut) {
            showSortByView = false
        }
    }

    func sortByViewDidSubmit() {
        withAnimation(.defaultEaseInOut) {
            showSortByView = false
        }
    }

    func clearFavoritesButtonDidTap() {
        assert(!showActionSheet)
        showActionSheet = true
    }

    func clearFavoritesDidConfirm() {
        showActionSheet = false
        viewModel.clearFavorites()
    }

    func clearFavoritesDidCancel() {
        showActionSheet = false
    }
}

private extension FavoritesSortByView {
    typealias Wrapped = PopupContainer<FilterContainer<FavoritesSortByView>>

    func wrapped(onShouldDismiss: @escaping () -> Void, onSubmit: @escaping () -> Void) -> Wrapped {
        PopupContainer(onShouldDismiss: onShouldDismiss) {
            FilterContainer(title: "Сортировать по", onSubmit: onSubmit) {
                self
            }
        }
    }
}

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
