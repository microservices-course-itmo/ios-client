//
//  SortBy.swift
//  WineUp
//
//  Created by Александр Пахомов on 06.10.2020.
//

import Foundation

enum SortBy {
    /// Show recommended first
    case recommended
    /// Show most rated first
    case basedOnRating
    /// Show lower price first
    case priceAsc
    /// Show higher price first
    case priceDesc
}
