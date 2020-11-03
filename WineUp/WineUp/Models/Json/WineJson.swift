//
//  WineJson.swift
//  WineUp
//
//  Created by Александр Пахомов on 03.11.2020.
//

import Foundation

struct WineJson: Decodable {
    var wineId: String
    var avg: Float
    var brandId: String
    var color: Color
    var grapeId: String
    var name: String
    var producerId: String
    var regionId: String
    var sugar: Sugar
    var year: Int
}

extension WineJson {
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

    struct CreateForm: Encodable {
        var avg: Float
        var brandId: String
        var color: Color
        var grapeId: String
        var name: String
        var producerId: String
        var regionId: String
        var sugar: Sugar
        var year: Int
    }

    struct UpdateForm: Encodable {
        var avg: Float
        var brandId: String
        var color: Color
        var grapeId: String
        var name: String
        var producerId: String
        var regionId: String
        var sugar: Sugar
        var year: Int
    }
}