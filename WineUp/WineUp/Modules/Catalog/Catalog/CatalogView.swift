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

// MARK: - Model

extension CatalogView {
    struct Item: Identifiable {
        var id = UUID()
        /// Title name of wine
        var title: String
        /// The country of manufacture
        var country: String
        /// Wine color (red/white/rose)
        var color: WineColor
        /// Wine astringency (dry/semi-dry/semi-sweet/sweet)
        var wineAstringency: WineAstringency
        /// Quantity of bottle in liters
        var quantityLiters: Float
        /// Is offer liked by the user
        var isLiked: Bool
        /// Compatibility percentage
        var chemistry: Float
        /// Title image of wine
        var titleImage: UIImage
        /// Retailer's logo
        var retailerImage: UIImage
        /// Rating of wine
        var rating: Float
        /// Price without discount in rub
        var originalPriceRub: Float
        /// Discount percentage
        var discountPercents: Float
    }
}

extension CatalogView.Item {
    /// Price with discount in rub
    var priceWithDiscount: Float {
        return originalPriceRub * ((100 - discountPercents) / 100)
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
