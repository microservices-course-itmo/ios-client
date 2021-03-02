//
//  WinePositionWebRepository.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 08.11.2020.
//

import Foundation
import Combine

// MARK: WineWebRepository

protocol WinePositionWebRepository: WebRepository {
    /// Create wine position with data from form
    func createWinePosition(from form: WinePositionJson.CreateForm) -> AnyPublisher<Void, Error>
    /// Delete wine position by id
    func deleteWinePosition(by id: String) -> AnyPublisher<Void, Error>
    /// Get list of all wine positions
    func getAllWinePositions() -> AnyPublisher<[WinePositionJson], Error>
    /// Get list of all wine positions
    func getAllWinePositionWithSettings(page: Int,
                                        amount: Int,
                                        filters: [WinePositionFilters],
                                        sortBy: FilterSortBy) -> AnyPublisher<[WinePositionJson], Error>
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
    let credentials: Store<Credentials?>
    private let bodyBuilder = WinePositionWebRepositoryQueryParametersBuidler()

    init(session: URLSession, baseURL: String, credentials: Store<Credentials?>) {
        self.session = session
        self.baseURL = baseURL
        self.credentials = credentials
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

    func getAllWinePositionWithSettings(page: Int,
                                        amount: Int,
                                        filters: [WinePositionFilters],
                                        sortBy: FilterSortBy) -> AnyPublisher<[WinePositionJson], Error> {
        let queryItems = bodyBuilder.build(page: page, amount: amount, filters: filters, sortBy: sortBy)
        return request(endpoint: .getAllWinePositionWithSettings(parameters: queryItems))
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

    static func getAllWinePositionWithSettings(parameters: QueryParameters) -> APICall {
        APICall(path: "/position/true/trueSettings",
                method: "GET",
                headers: HTTPHeaders.empty.mockedAccessToken(),
                parameters: parameters)
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
