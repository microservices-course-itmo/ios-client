//
//  WinePositionWebRepository.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 08.11.2020.
//

import Foundation
import Combine

// MARK: WineWebRepository

// swiftlint:disable identifier_name
protocol WinePositionWebRepository: WebRepository {
    /// Create wine position with data from form
    func createWinePosition(from form: WinePositionJson.CreateForm) -> AnyPublisher<Void, Error>
    /// Delete wine position by id
    func deleteWinePosition(by id: String) -> AnyPublisher<Void, Error>
    /// Get list of all wine positions
    func getAllWinePositions() -> AnyPublisher<[WinePositionJson], Error>
    /// Get list of all wine positions
    func getAllWinePositionWithSettings(from: Int,
                                        to: Int,
                                        filters: [WinePositionFilters],
                                        sortBy: [FilterSortBy]) -> AnyPublisher<[WinePositionJson], Error>
    /// Get list of all wine positions with parameters
    func getAllWinePositionByName(name: String) -> AnyPublisher<[WinePositionJson], Error>
    /// Get wine position by id
    func getWinePosition(by id: String) -> AnyPublisher<WinePositionJson, Error>
    /// Update wine position by id with data from form
    func updateWinePosition(by id: String, with form: WinePositionJson.UpdateForm) -> AnyPublisher<Void, Error>
}

// MARK: - Implementation

final class RealWinePositionWebRepository: WinePositionWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    private let bodyBuilder = WinePositionWebRepositoryURLQueryBuidler()

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func createWinePosition(from form: WinePositionJson.CreateForm) -> AnyPublisher<Void, Error> {
        call(endpoint: .createWinePosition(form))
    }

    func deleteWinePosition(by id: String) -> AnyPublisher<Void, Error> {
        call(endpoint: .deleteWinePosition(by: id))
    }

    func getAllWinePositions() -> AnyPublisher<[WinePositionJson], Error> {
        request(endpoint: .getAllWinePositions())
    }

    func getAllWinePositionWithSettings(from: Int,
                                        to: Int,
                                        filters: [WinePositionFilters],
                                        sortBy: [FilterSortBy]) -> AnyPublisher<[WinePositionJson], Error> {

        // example filters
//        let filters: [WinePositionFilters] =
//            [.value(.init(criterion: .price, operation: .less, value: "1000")),
//             .separator(.or),
//             .value(.init(criterion: .volume, operation: .less, value: "0.5"))]
        let queryItems = bodyBuilder.build(from: from, to: to, filters: filters, sortBy: sortBy)
        return request(endpoint: .getAllWinePositionWithSettings(queryItems: queryItems))
    }

    func getAllWinePositionByName(name: String) -> AnyPublisher<[WinePositionJson], Error> {
        request(endpoint: .getAllWinePositionByName(name: name))
    }

    func getWinePosition(by id: String) -> AnyPublisher<WinePositionJson, Error> {
        request(endpoint: .getWinePosition(by: id))
    }

    func updateWinePosition(by id: String, with form: WinePositionJson.UpdateForm) -> AnyPublisher<Void, Error> {
        call(endpoint: .updateWinePosition(by: id, with: form))
    }
}

// MARK: - Helpers

private extension APICall {
    static func createWinePosition(_ form: WinePositionJson.CreateForm) -> APICall {
        APICall(path: "/wine/position", method: "POST", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }

    static func deleteWinePosition(by id: String) -> APICall {
        APICall(path: "/wine/position/\(id)", method: "DELETE", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getAllWinePositions() -> APICall {
        APICall(path: "/wine/position", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getAllWinePositionWithSettings(queryItems: [URLQueryItem]) -> APICall {
        APICall(path: "/position/true",
                method: "GET",
                headers: HTTPHeaders.empty.mockedAccessToken(),
                queryItems: queryItems)
    }

    static func getAllWinePositionByName(name: String) -> APICall {
        APICall(path: "/wine/position/\(name)", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getWinePosition(by id: String) -> APICall {
        APICall(path: "/wine/position/\(id)", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func updateWinePosition(by id: String, with form: WinePositionJson.UpdateForm) -> APICall {
        APICall(path: "/wine/position/\(id)", method: "PUT", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }
}
