//
//  CatalogView.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.09.2020.
//

import SwiftUI

// MARK: - View

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

// MARK: - Model

extension CatalogView {
    struct Item: Identifiable {
        var id = UUID()
        var title: String
        var country: String
        var color: WineColor
        var wineAstringency: WineAstringency
        var quantityLiters: Float
        var isLiked: Bool
        var chemistry: Float
        var titleImage: UIImage
        var retailerImage: UIImage
        var rating: Float
        var originalPriceRub: Float
        var discountPercents: Float
    }
}

extension CatalogView.Item {
    var priceWithDiscount: Float {
        let result = self.originalPriceRub * ((100 - self.discountPercents) / 100)
        return Float(result)
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
