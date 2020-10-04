//
//  CatalogItemModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 04.10.2020.
//

import UIKit
import Rswift

struct CatalogItemModel: Identifiable {
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

// MARK: - Helpers

extension CatalogItemModel {
    var priceWithDiscount: Float {
        let result = self.originalPriceRub * ((100 - self.discountPercents) / 100)
        return Float(result)
    }

    var wineDescription: String {
        return "\(country), \(color.name), \(wineAstringency.name), \(quantityLiters) л"
    }
}
