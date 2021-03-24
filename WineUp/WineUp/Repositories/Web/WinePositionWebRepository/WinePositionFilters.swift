//
//  WinePositionFilters.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 22.11.2020.
//

import Foundation

enum WinePositionFilters {
    case value(WinePositionFiltersValue)
    case separator(FiltersSeparators)
}

struct WinePositionFiltersValue: CustomStringConvertible {
    let criterion: WinePositionCriteries
    let operation: FiltersOperations
    let value: String

    var description: String {
        // Don't known why '`' is required before any search params, but it works
        criterion.rawValue + operation.rawValue + value + ";"
    }
}

enum FiltersOperations: String {
    case equal = ":"
    case less = "<"
    case more = ">"
}

enum FiltersSeparators: String {
    // swiftlint:disable identifier_name
    case or = "~"
    case and = "*"
}

enum WinePositionCriteries: String {
    /// сайт магазина
    case shopSite
    /// название производителя
    case producerName
    /// название бренда
    case brandName
    /// название региона
    case regionName
    /// название страны
    case countryName
    /// сорт винограда
    case grapeName
    /// крепость
    case avg
    /// цвет
    case color
    /// Сладость
    case sugar
    /// год производства
    case year
    /// цена
    case price
    /// актуальная цена
    case actualPrice = "actual_price"
    /// объем
    case volume
}

enum WinePositionSortableCriteries: String, Encodable {
    ///  крепость
    case avg
    /// год производства
    case year
    /// цена
    case price
    /// актуальная цен
    case actualPrice = "actual_price"
    /// объем
    case volume
}

struct FilterSortBy: Encodable {
    let attributeName: WinePositionSortableCriteries
    let order: Order
}

enum Order: String, Encodable {
    case asc
    case desc
}
