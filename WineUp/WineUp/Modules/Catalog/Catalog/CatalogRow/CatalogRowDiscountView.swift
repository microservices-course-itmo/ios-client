//
//  CatalogRowDiscountView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

struct CatalogRowDiscountView: View {
    
    // MARK: - Private Properties
    
    let item: CatalogItemModel

    // MARK: - Lifecycle
    
    init(item: CatalogItemModel) {
        self.item = item
    }
    
    // MAR: - View
    
    var body: some View {
        VStack {
            HStack {
                Text("\(Int(item.priceWithDiscount))₽")
                    .font(.system(size: 12))
                    .strikethrough()
                    .fontWeight(.bold)
                
                Text("-\(Int(item.discountPercents))%")
                    .font(.system(size: 11))
                    .foregroundColor(.red)
                    .fontWeight(.bold)
            }
            HStack {
                Text("\(Int(item.originalPriceRub))₽")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
            }
        }
    }
}

// MARK: - Preview Settings
#if DEBUG
struct CatalogRowDiscountView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogRowDiscountView(item: CatalogItemModel(title: "ASD"))
            .previewLayout(.fixed(width: 150, height: 50))
    }
}
#endif
