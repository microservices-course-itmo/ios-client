//
//  WinePositionJson.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 08.11.2020.
//

import Foundation

struct WinePositionJson: Decodable {
    var id = String
    var title: String
    var country: String
    var color: Color
    var year: String
    var wineAstringency: Sugar
    var quantityLiters: Float
    var isLiked: Bool
    var chemistry: Float
    var titleImage: String
    var retailerName: String
    var rating: Float
    var originalPriceRub: Float
    var discountPercents: Float
    var details: Details
}

extension WinePositionJson {
    enum Color: String, Codable {
        case red
        case white
        case rose
    }

    enum Sugar: String, Codable {
        case dry
        case semiDry
        case semiSweet
        case sweet
    }

    struct Details: Decodable {
        var winePositionId: String
        var tasteDescription: String
        var dishSuggestions: String
        var reviews: [ReviewJson]
        var suggestions: [WinePositionJson]
    }

    struct CreateForm: Encodable {
        var title: String
        var country: String
        var color: Color
        var year: String
        var wineAstringency: Sugar
        var quantityLiters: Float
        var isLiked: Bool
        var chemistry: Float
        var titleImage: String
        var retailerName: String
        var rating: Float
        var originalPriceRub: Float
        var discountPercents: Float
        var details: Details
    }

    struct UpdateForm: Encodable {
        var title: String
        var country: String
        var color: Color
        var year: String
        var wineAstringency: Sugar
        var quantityLiters: Float
        var isLiked: Bool
        var chemistry: Float
        var titleImage: String
        var retailerName: String
        var rating: Float
        var originalPriceRub: Float
        var discountPercents: Float
        var details: Details
    }
}
