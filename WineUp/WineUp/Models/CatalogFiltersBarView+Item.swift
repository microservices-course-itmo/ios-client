//
//  CatalogFiltersBarView+Item.swift
//  WineUp
//
//  Created by Александр Пахомов on 05.10.2020.
//

import Foundation

extension CatalogFiltersBarView {
    struct Item: Identifiable {
        var id = UUID()
        /// Filter name
        var title: String
    }
}
