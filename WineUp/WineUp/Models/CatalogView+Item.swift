//
//  CatalogView+Item.swift
//  WineUp
//
//  Created by Александр Пахомов on 05.10.2020.
//

import Foundation
import UIKit.UIImage

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
