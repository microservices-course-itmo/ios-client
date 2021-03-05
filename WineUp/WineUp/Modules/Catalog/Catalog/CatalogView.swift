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
    static let wineCardsSpacing: CGFloat = 10
}

private extension LocalizedStringKey {
    static let navigationTitle = LocalizedStringKey("Каталог")
}

// MARK: - View

/// Stack of filters and list of catalog offers
struct CatalogView: View {

    @StateObject var viewModel: ViewModel
    @StateObject private var filtersViewModel = FiltersViewModel()

    var body: some View {
        ZStack {
            content()
                .navigationTitle(.navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(false)

            if let item = viewModel.presentedFiltersBarItem {
                wrappedFilterViewFor(item: item)
                    .transition(.opacity)
            }
        }
    }

    // MARK: Helpers

    @ViewBuilder
    private func content() -> some View {
        switch viewModel.catalogItems {
        case let .failed(error):
            Text(error.description)
        case .isLoading:
            Text("Loading")
        case .notRequested:
            Text("Waiting")
                .onAppear {
                    loadCatalogItems()
                }
        case let .loaded(winePositions):
            winePositionsContent(winePositions: winePositions)
        }
    }

    private func winePositionsContent(winePositions: [WinePosition]) -> some View {
        VStack(spacing: .rootVStackSpacing) {
            SearchBarView(text: $viewModel.searchText)

            CatalogFiltersBarView(items: viewModel.filtersBarItems) { item in
                withAnimation(.defaultEaseInOut) {
                    viewModel.filterItemDidTap(item)
                }
            }

            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach(winePositions) { item in
                        NavigationLink(
                            destination: WinePositionDetailsView(
                                viewModel: viewModel.winePositionDetailsViewModelFor(item)),
                            tag: item.id,
                            selection: $viewModel.selectedCatalogItemId, label: {
                                WinePositionView(item: item, onLikeButtonTap: { viewModel.toggleLike(of: item) })
                                    .foregroundColor(.black)
                                    .padding()
                                    .cardStyled()
                                    .padding(.wineCardsSpacing)
                            }
                        )
                    }
                }
            }
        }

    }

    @ViewBuilder
    private func wrappedFilterViewFor(item: CatalogFiltersBarView.Item) -> some View {
        switch item {
        case .recomendation:
            wrapFilter(
                RecommendationFilter(selected: $filtersViewModel.sortByTemp),
                title: "Рекомендации"
            )
        case .price:
            wrapFilter(
                PriceFilter(),
                title: "Цена"
            )
        case .country:
            wrapFilter(
                CountryFilterView(selected: $filtersViewModel.countriesTemp),
                title: "Страна"
            )
        case .wineSugar:
            wrapFilter(
                WineSugarFilter(selected: $filtersViewModel.sugarTemp),
                title: "Сахар"
            )
        case .wineColor:
            wrapFilter(
                WineColorFilter(selected: $filtersViewModel.colorTemp),
                title: "Цвет"
            )
        }
    }

    private func wrapFilter<V: View>(_ filter: V, title: String) -> some View {
        PopupContainer(onShouldDismiss: {
            filtersViewModel.restoreFilters()
            dismissFilterAnimated()
        }, label: {
            SubmitDialog(title: title, onSubmit: {
                filtersViewModel.commitFilters()
                loadCatalogItems()
                dismissFilterAnimated()
            }, label: {
                filter
            })
        })
    }

    private func dismissFilterAnimated() {
        withAnimation(.defaultEaseInOut) {
            viewModel.dismissFilterDidTap()
        }
    }

    private func loadCatalogItems() {
        viewModel.loadCatalogItems(
            colors: filtersViewModel.color,
            sugar: filtersViewModel.sugar,
            countries: filtersViewModel.countries,
            sortBy: filtersViewModel.sortBy
        )
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CatalogView(viewModel: .preview)
        }
    }
}
#endif
