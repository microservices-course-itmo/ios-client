//
//  TrueWinePositionRecommendationJson.swift
//  WineUp
//
//  Created by Александр Пахомов on 28.03.2021.
//

import Foundation

struct TrueWinePositionRecommendationJson: Decodable {
    var winePosition: TrueWinePositionJson
    var recommendations: [TrueWinePositionJson]
}
