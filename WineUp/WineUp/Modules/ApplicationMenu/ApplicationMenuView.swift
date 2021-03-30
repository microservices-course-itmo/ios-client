//
//  ApplicationMenuView.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension Image {
    static let mainTab = Image(systemName: "house.fill")
    static let catalogTab = Image(systemName: "book.fill")
    static let favoritesTab = Image(systemName: "star.fill")
    static let profileTab = Image(systemName: "person.fill")
}

private extension LocalizedStringKey {
    static let mainTab = LocalizedStringKey("Рекомендуем")
    static let catalogTab = LocalizedStringKey("Каталог")
    static let favoritesTab = LocalizedStringKey("Избранное")
    static let profileTab = LocalizedStringKey("Профиль")
}

// MARK: - View

/// TabView of application main modules like Catalog, Main, Favorites and Profile
struct ApplicationMenuView: View {

    @StateObject var viewModel: ViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            RecommendationsRootView(viewModel: viewModel.recomendationsViewModel)
                .tabItem {
                    Image.mainTab
                    Text(LocalizedStringKey.mainTab)
                }
                .tag(Tab.main)

            CatalogRootView(viewModel: viewModel.catalogRootViewModel)
                .tabItem {
                    Image.catalogTab
                    Text(LocalizedStringKey.catalogTab)
                }
                .tag(Tab.catalog)

            FavoritesRootView(viewModel: viewModel.favoritesRootViewModel)
                .tabItem {
                    Image.favoritesTab
                    Text(LocalizedStringKey.favoritesTab)
                }
                .tag(Tab.favorites)

            ProfileView(viewModel: viewModel.profileViewModel)
                .tabItem {
                    Image.profileTab
                    Text(LocalizedStringKey.profileTab)
                }
                .tag(Tab.profile)
        }
        .overlay(
            // Using overlay with Color.clear because of bug with nested fullScreenCovers
            Color.clear
                .frame(width: 0, height: 0)
                .fullScreenCover(item: $viewModel.winePosition) {
                    WinePositionDetailsView(viewModel: viewModel.winePositionDetailsViewModel(for: $0))
                        .overlay(
                            Button("Закрыть") {
                                self.viewModel.winePosition = nil
                            }
                            .padding()
                            .verticallySpanned(alignment: .top)
                            .horizontallySpanned(alignment: .leading)
                        )
                }
        )
        .onAppear {
            viewModel.addAPNS()
        }
    }
}

// MARK: - Preview

#if DEBUG
struct ApplicationMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationMenuView(viewModel: .preview)
    }
}
#endif
