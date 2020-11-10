//
//  WinePositionJson.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 08.11.2020.
//

import Foundation

struct WinePositionJson: Decodable {
    var price: Float
    var description: String
    var gastronomy: String
    var image: String
    var link: String
    var price: Float
    var shopID: String
    var volume: Float
    var wineID: String
    var winePositionID: String
}

extension WinePositionJson {

    struct CreateForm: Encodable {
        var price: Float
        var description: String
        var gastronomy: String
        var image: String
        var link: String
        var price: Float
        var shopID: String
        var volume: Float
        var wineID: String
    }

    struct UpdateForm: Encodable {
        var price: Float
        var description: String
        var gastronomy: String
        var image: String
        var link: String
        var price: Float
        var shopID: String
        var volume: Float
        var wineID: String
    }
}
