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
    static let navigationTitle = LocalizedStringKey("Каталог")
}

// MARK: - View

/// Stack of filters and list of catalog offers
struct CatalogView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        ZStack {
            content()

            if let item = viewModel.presentedFiltersBarItem {
                wrappedFilterViewFor(item: item)
                    .transition(.opacity)
            }
        }
    }

    // MARK: Helpers

    private func content() -> some View {
        VStack(spacing: .rootVStackSpacing) {
            SearchBarView(text: $viewModel.searchText)

            CatalogFiltersBarView(items: viewModel.filtersBarItems) { item in
                withAnimation(.defaultEaseInOut) {
                    viewModel.filterItemDidTap(item)
                }
            }

            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach(viewModel.catalogItems) { item in
                        WinePositionView(item: item)
                            .padding()
                    }
                }
            }
        }
        .navigationTitle(.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
    }

    private func wrappedFilterViewFor(item: CatalogFiltersBarView.Item) -> some View {
        switch item {
        case .recomendation:
            return wrapFilter(
                RecommendationFilter(viewModel: viewModel.recommendationFilterViewModel),
                title: "Рекомендации"
            )
        case .price:
            return wrapFilter(
                PriceFilter(viewModel: viewModel.priceFilterViewModel),
                title: "Цена"
            )
        case .country:
            return wrapFilter(
                CountryFilterView(viewModel: viewModel.countryFilterViewModel),
                title: "Страна"
            )
        case .wineAstringency:
            return wrapFilter(
                WineAstringencyFilter(viewModel: viewModel.wineAstringencyFilterViewModel),
                title: "Сахар"
            )
        case .wineColor:
            return wrapFilter(
                WineColorFilter(viewModel: viewModel.wineColorFilterViewModel),
                title: "Цвет"
            )
        }
    }

    private func wrapFilter<V: View>(_ filter: V, title: String) -> AnyView {
        PopupContainer(onShouldDismiss: {
            withAnimation(.defaultEaseInOut) {
                viewModel.dismissFilterDidTap()
            }
        }, label: {
            SubmitDialog(title: title, onSubmit: {}, label: {
                filter
            })
        })
        .anyView
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
