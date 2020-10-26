//
//  WinePositionView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let previewWidth: CGFloat = 110
    static let previewHeight: CGFloat = 330
}

// MARK: - View

/// Catalog item visual representation (like `UITableViewCell`)
struct WinePositionView: View {

    let item: WinePosition

    var body: some View {
        HStack {
            PreviewImageView(item: item)
                .frame(
                    width: .previewWidth,
                    height: .previewHeight,
                    alignment: .center
                )
            InfoView(item: item)
        }
    }
}

// MARK: - Model

struct WinePosition: Identifiable, Equatable {
    var id = UUID()
    /// Title name of wine
    var title: String
    /// The country of manufacture
    var country: String
    /// Wine color (red/white/rose)
    var color: WineColor
    /// Production year
    var year: String
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
    var retailerName: String
    /// Rating of wine
    var rating: Float
    /// Price without discount in rub
    var originalPriceRub: Float
    /// Discount percentage
    var discountPercents: Float
    /// Price with discount in rub
    var priceWithDiscount: Float {
        return originalPriceRub * ((100 - discountPercents) / 100)
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRowView_Previews: PreviewProvider {
    static var previews: some View {
        let item = WinePosition.mockedData[1]
        return WinePositionView(item: item)
            .previewLayout(.fixed(width: 414, height: 350))
    }
}
#endif
