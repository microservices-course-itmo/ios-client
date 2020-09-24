//
//  CatalogItemModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import UIKit

final class CatalogItemModel: Identifiable, CustomStringConvertible {
    var id: UUID
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

    init(title: String, country: String, color: WineColor, wineAstringency: WineAstringency, quantityLiters: Float, isLiked: Bool, chemistry: Float, titleImage: UIImage, retailerImage: UIImage, rating: Float, originalPriceRub: Float, discountPercents: Float) {
        self.id = UUID()
        self.title = title
        self.country = country
        self.color = color
        self.wineAstringency = wineAstringency
        self.quantityLiters = quantityLiters
        self.isLiked = isLiked
        self.chemistry = chemistry
        self.titleImage = titleImage
        self.retailerImage = retailerImage
        self.rating = rating
        self.originalPriceRub = originalPriceRub
        self.discountPercents = discountPercents
    }

    convenience init(title: String) {
        self.init(title: title, country: "", color: .red, wineAstringency: .dry, quantityLiters: 0, isLiked: false, chemistry: 0, titleImage: UIImage(), retailerImage: UIImage(), rating: 0, originalPriceRub: 0, discountPercents: 0)
    }

    var description: String {
        return "CatalogItem(id=\(id), title='\(title)')"
    }
}

enum WineColor {
    case red, white, rose
}

enum WineAstringency {
    case dry, semiDry, semiSweet, sweet
}
