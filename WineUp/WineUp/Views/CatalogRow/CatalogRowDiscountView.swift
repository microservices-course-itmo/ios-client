//
//  CatalogRowDiscountView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

struct CatalogRowDiscountView: View {

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

// MARK: - Helpers

private extension CatalogRowDiscountView {
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
struct CatalogRowDiscountView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogRowDiscountView(item: CatalogView.Item.mockedData[0])
            .previewLayout(.fixed(width: 150, height: 50))
    }
}
#endif
