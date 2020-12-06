//
//  WinePositionWebRepositoryBodyBuidler.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 22.11.2020.
//

import Foundation

final class WinePositionWebRepositoryQueryParametersBuidler {

    func build(from: Int, to: Int, filters: [WinePositionFilters], sortBy: [FilterSortBy]) -> QueryParameters {
        ["from": from.description,
         "to": to.description,
         "searchParameters": buildSearchParameters(for: filters),
         // TODO: из тз не понятно как формировать несколько правил сортировки
         "sortByPair": "avg&desc"]
    }

    // MARK: - Private

    private func buildSearchParameters(for filters: [WinePositionFilters]) -> String {
        return filters.reduce(into: "") { res, filter in
            switch filter {
            case .separator(let sep):
                res += sep.rawValue
            case .value(let value):
                res += value.description
            }
        }
    }
}
