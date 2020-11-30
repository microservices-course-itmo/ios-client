//
//  WinePositionWebRepositoryBodyBuidler.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 22.11.2020.
//

import Foundation

final class WinePositionWebRepositoryBodyBuidler {
    // swiftlint:disable identifier_name

    // Nested
    struct FiltersBody: Encodable {
        let from: Int
        let to: Int
        let searchParameters: String
        let sortBy: [FilterSortBy]
    }

    func build(from: Int, to: Int, filters: [WinePositionFilters], sortBy: [FilterSortBy]) -> FiltersBody {
        .init(from: from,
              to: to,
              searchParameters: buildSearchParameters(for: filters),
              sortBy: sortBy)
    }

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
