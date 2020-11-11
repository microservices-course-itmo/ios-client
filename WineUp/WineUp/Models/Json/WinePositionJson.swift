//
//  WinePositionJson.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 08.11.2020.
//

import Foundation

struct WinePositionJson: Decodable {
    var actualPrice: Float
    var description: String
    var gastronomy: String
    var image: String
    var linkToWine: String
    var price: Float
    var shopId: String
    var volume: Float
    var wineId: String
    var winePositionId: String
}

extension WinePositionJson {

    struct CreateForm: Encodable {
        var actualPrice: Float
        var description: String
        var gastronomy: String
        var image: String
        var linkToWine: String
        var price: Float
        var shopId: String
        var volume: Float
        var wineId: String
    }

    struct UpdateForm: Encodable {
        var actualPrice: Float
        var description: String
        var gastronomy: String
        var image: String
        var linkToWine: String
        var price: Float
        var shopId: String
        var volume: Float
        var wineId: String
    }
}
