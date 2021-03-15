//
//  TrueWinePositionJson.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.11.2020.
//

import Foundation

struct TrueWinePositionJson: Decodable {
    var winePositionId: String
    var actualPrice: Float
    var description: String
    var gastronomy: String
    /// Image URL
    var image: String
    var linkToWine: String
    var price: Float
    var shop: ShopJson
    var volume: Float
    var wine: TrueWineJson
    var isLiked: Bool?
}

struct TrueWineJson: Decodable {
    var wineId: String
    var avg: Float
    var brand: BrandJson
    var color: WineJson.Color
    var grape: [GrapeJson]
    var name: String
    var producer: ProducerJson
    var region: [RegionJson]
    var sugar: WineJson.Sugar
    var year: Int
}
