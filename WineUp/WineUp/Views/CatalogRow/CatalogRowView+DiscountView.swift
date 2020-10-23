//
//  CatalogRowView+DiscountView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension Font {
    static let priceWithDiscount: Font = .system(size: 12, weight: .bold)
    static let discountPercents: Font = .system(size: 11, weight: .bold)
    static let originalPrice: Font = .system(size: 24, weight: .bold)
}

private extension Color {
    static let discountPercents: Color = .red
}

// MARK: - View

extension CatalogRowView {
    /// Catalog item price offer view
    struct DiscountView: View {

        let item: CatalogView.RowItem

        var body: some View {
            VStack {
                HStack {
                    Text(priceWithDiscountText)
                        .font(.priceWithDiscount)
                        .strikethrough()
                    Text(discountPercentsText)
                        .font(.discountPercents)
                        .foregroundColor(.discountPercents)
                }
                HStack {
                    Text(originalPriceRubText)
                        .font(.originalPrice)
                }
            }
        }

        // MARK: Helpers

        private var priceWithDiscountText: String {
            let priceWithDiscount = Int(item.priceWithDiscount)
            return "\(priceWithDiscount)₽"
        }

        private var discountPercentsText: String {
            let discountPercents = Int(item.discountPercents)
            return "-\(discountPercents)₽"
        }

        private var originalPriceRubText: String {
            let originalPriceRun = Int(item.originalPriceRub)
            return "\(originalPriceRun)₽"
        }
    }
}

// MARK: - Preview Settings

#if DEBUG
struct CatalogRowViewDiscountView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogRowView.DiscountView(item: CatalogView.RowItem.mockedData[0])
            .previewLayout(.fixed(width: 150, height: 50))
    }
}
#endif
