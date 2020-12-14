//
//  WinePosition.swift
//  WineUp
//
//  Created by Александр Пахомов on 03.11.2020.
//

import UIKit
import Foundation

struct WinePosition: Identifiable, Equatable {
    var id: String = UUID().uuidString
    /// Title name of wine
    var title: String
    /// The country of manufacture
    var country: String
    /// Wine color (red/white/rose)
    var color: WineColor
    /// Production year
    var year: String
    /// Wine astringency (dry/semi-dry/semi-sweet/sweet)
    var wineSugar: WineSugar
    /// Quantity of bottle in liters
    var quantityLiters: Float
    /// Is offer liked by the user
    var isLiked: Bool
    /// Compatibility percentage
    var chemistry: Float
    /// Universe Url of title image
    var titleImageUrl: UniverseUrl
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

extension WinePosition {
    struct Details: Equatable {
        /// Id of corresponding wine position
        var winePositionId: String
        /// Description of wine taste
        var tasteDescription: String
        /// Text with suggestion which food to combine the wine with
        var dishSuggestions: String
        /// List of reviews of the wine
        var reviews: [Review]
        /// List of suggested wines
        var suggestions: [WinePosition]
    }
}
