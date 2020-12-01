//
//  TrueWinePositionWebRepository.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.11.2020.
//

import Foundation
import Combine

// MARK: - TrueWinePositionWebRepository

protocol TrueWinePositionWebRepository: WebRepository {
    func getAllTrueWinePositions(from: Int,
                                 to: Int,
                                 filters: [WinePositionFilters],
                                 sortBy: [FilterSortBy]) -> AnyPublisher<[TrueWinePositionJson], Error>
}

// MARK: - Implementation

final class RealTrueWinePositionWebRepository: TrueWinePositionWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    private let queryParamsBuilder = WinePositionWebRepositoryQueryParametersBuidler()

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func getAllTrueWinePositions(from: Int,
                                 to: Int,
                                 filters: [WinePositionFilters],
                                 sortBy: [FilterSortBy]) -> AnyPublisher<[TrueWinePositionJson], Error> {
        let parameters = queryParamsBuilder.build(from: from, to: to, filters: filters, sortBy: sortBy)
        return request(endpoint: .getAllTrueWinePositions(parameters: parameters))
    }
}

// MARK: - Helpers

private extension APICall {
    static func getAllTrueWinePositions(parameters: QueryParameters) -> APICall {
        APICall(path: "/position/true/", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken(), parameters: parameters)
    }
}
