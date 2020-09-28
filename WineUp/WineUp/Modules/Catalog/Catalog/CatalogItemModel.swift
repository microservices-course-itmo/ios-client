//
//  CatalogItemModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import UIKit
import Rswift

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

    init(title: String,
         country: String,
         color: WineColor,
         wineAstringency: WineAstringency,
         quantityLiters: Float,
         isLiked: Bool,
         chemistry: Float,
         titleImage: UIImage,
         retailerImage: UIImage,
         rating: Float,
         originalPriceRub: Float,
         discountPercents: Float) {
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

    // TODO: Rewrite this method with buissnes logic aspects

    var priceWithDiscount: Float {
        let result = self.originalPriceRub * ((100 - self.discountPercents) / 100)
        return Float(result)
    }

    var wineDescription: String {
        return "\(country), \(color.name), \(wineAstringency.name), \(quantityLiters) л"
    }

    // TODO: Must be removed after test data is imported into project
    convenience init(title: String) {
        self.init(title: title,
                  country: "Украина",
                  color: .red,
                  wineAstringency: .dry,
                  quantityLiters: 2,
                  isLiked: false,
                  chemistry: 3,
                  titleImage: UIImage(named: "Red_and_white_wine_12-2015")!,
                  retailerImage: UIImage(named: "image 4")!,
                  rating: 3,
                  originalPriceRub: 1_400,
                  discountPercents: 20)
    }

    var description: String {
        return "CatalogItem(id=\(id), title='\(title)')"
    }
}

enum WineColor {
    case red, white, rose

    // TODO: Create localize file with localization, can use Rswift for accessing it

    var name: String {
        switch self {
        case .red:
            return "Красное"
        case .white:
            return "Белое"
        case .rose:
            return "Розовое"
        }
    }
}

enum WineAstringency {
    case dry, semiDry, semiSweet, sweet

    // TODO: Create localize file with localization, can use Rswift for accessing it

    var name: String {
        switch self {
        case .dry:
            return "Сухое"
        case .semiDry:
            return "Полусухое"
        case .semiSweet:
            return "Полусладкое"
        case .sweet:
            return "Сладкое"
        }
    }
}
