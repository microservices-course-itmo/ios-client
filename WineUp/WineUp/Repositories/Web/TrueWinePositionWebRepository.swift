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
    func getAllTrueWinePositions(page: Int,
                                 amount: Int,
                                 filters: [WinePositionFilters],
                                 sortBy: FilterSortBy) -> AnyPublisher<[TrueWinePositionJson], Error>

    func getTrueWinePositions(by ids: [String]) -> AnyPublisher<[TrueWinePositionJson], Error>

    func getFavoritesTrueWinePositions() -> AnyPublisher<[TrueWinePositionJson], Error>
}

// MARK: - Implementation

final class RealTrueWinePositionWebRepository: TrueWinePositionWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let credentials: Store<Credentials?>

    private let queryParamsBuilder = WinePositionWebRepositoryQueryParametersBuidler()

    init(session: URLSession, baseURL: String, credentials: Store<Credentials?>) {
        self.session = session
        self.baseURL = baseURL
        self.credentials = credentials
    }

    func getAllTrueWinePositions(page: Int,
                                 amount: Int,
                                 filters: [WinePositionFilters],
                                 sortBy: FilterSortBy) -> AnyPublisher<[TrueWinePositionJson], Error> {
        let parameters = queryParamsBuilder.build(page: page, amount: amount, filters: filters, sortBy: sortBy)
        return request(endpoint: .getAllTrueWinePositions(parameters: parameters))
    }

    func getTrueWinePositions(by ids: [String]) -> AnyPublisher<[TrueWinePositionJson], Error> {
        if ids.isEmpty {
            // Catalog service will return 400 if list if empty
            return Just<[TrueWinePositionJson]>.withErrorType([], Error.self)
                .eraseToAnyPublisher()
        } else {
            return request(endpoint: .getTrueWinePositions(by: ids))
        }
    }

    func getFavoritesTrueWinePositions() -> AnyPublisher<[TrueWinePositionJson], Error> {
        request(endpoint: .getFavoriteWinePositions())
    }
}

// MARK: - Helpers

private extension APICall {
    static func getAllTrueWinePositions(parameters: QueryParameters) -> APICall {
        APICall(path: "/position/true/trueSettings/", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken(), parameters: parameters)
    }

    static func getTrueWinePositions(by ids: [String]) -> APICall {
        let parameters = ids.map { ("favouritePosition", $0) }
        return APICall(path: "/position/true/favourites/", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken(), parameters: parameters)
    }

    static func getFavoriteWinePositions() -> APICall {
        APICall(path: "/favorites/", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }
}
