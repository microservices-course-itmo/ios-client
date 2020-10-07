//
//  RecomendedFilter+ItemsList+Item.swift
//  WineUp
//
//  Created by Александр Пахомов on 07.10.2020.
//

import Foundation

extension RecommendationFilter.ItemsList {
    /// 
    struct Item: Identifiable {
        var id = UUID()
        ///
        var sortOrder: CatalogSortOrder
    }
}

extension RecommendationFilter.ItemsList.Item: Equatable {

}
