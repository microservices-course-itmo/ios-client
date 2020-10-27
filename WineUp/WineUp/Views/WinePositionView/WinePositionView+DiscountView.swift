//
//  WinePositionView+DiscountView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension Font {
    static let priceWithDiscount: Font = .system(size: 24, weight: .medium)
    static let originalPrice: Font = .system(size: 12, weight: .medium)
    static let itemPrice: Font = .system(size: 20, weight: .regular)
}

private extension Color {
    static let discountPercents: Color = .red
}

// MARK: - View

extension WinePositionView {
    /// Catalog item price offer view
    struct DiscountView: View {

        let item: WinePosition

        var body: some View {
            VStack(alignment: .trailing) {
                HStack {
                    Text(originalPriceRubText)
                        .font(.originalPrice)
                        .strikethrough()
                }
                HStack {
                    Text("Стоимость:")
                        .font(.itemPrice)

                    Spacer()

                    Text(priceWithDiscountText)
                        .font(.priceWithDiscount)
                }
            }
        }

        // MARK: Helpers

        private var priceWithDiscountText: String {
            let priceWithDiscount = Int(item.priceWithDiscount)
            return "\(priceWithDiscount)₽"
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
        WinePositionView.DiscountView(item: WinePosition.mockedData[1])
            .previewLayout(.fixed(width: 250, height: 150))
    }
}
#endif
