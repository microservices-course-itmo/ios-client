//
//  CatalogRowView+DiscountView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - View

extension CatalogRowView {
    /// Catalog item price offer view
    struct DiscountView: View {

        let item: CatalogView.Item

        var body: some View {
            VStack {
                HStack {
                    Text(priceWithDiscountText)
                        .font(.system(size: 12))
                        .strikethrough()
                        .fontWeight(.bold)
                    Text(discountPercentsText)
                        .font(.system(size: 11))
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                }
                HStack {
                    Text(originalPriceRubText)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                }
            }
        }
    }
}

// MARK: - Helpers

private extension CatalogRowView.DiscountView {
    var priceWithDiscountText: String {
        let priceWithDiscount = Int(item.priceWithDiscount)
        return "\(priceWithDiscount)₽"
    }

    var discountPercentsText: String {
        let discountPercents = Int(item.discountPercents)
        return "-\(discountPercents)₽"
    }

    var originalPriceRubText: String {
        let originalPriceRun = Int(item.originalPriceRub)
        return "\(originalPriceRun)₽"
    }
}

// MARK: - Preview Settings

#if DEBUG
struct CatalogRowViewDiscountView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogRowView.DiscountView(item: CatalogView.Item.mockedData[0])
            .previewLayout(.fixed(width: 150, height: 50))
    }
}
#endif
