//
//  PriceFilterView+Item.swift
//  WineUp
//
//  Created by Александр Пахомов on 05.10.2020.
//

import Foundation

extension PriceFilterView {
    /// Predefined price interval like `500-1000`
    struct Item: Identifiable {
        var id = UUID()
        /// Text representation like `500-1000`
        var title: String
    }
}

extension PriceFilterView.Item: Equatable {

}
