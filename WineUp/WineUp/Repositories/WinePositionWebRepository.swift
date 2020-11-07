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
    func getAllWinePosition() -> AnyPublisher<[WinePositionJson], Error>
    /// Get list of all wine positions
    func getAllWinePosition1() -> AnyPublisher<[WinePositionJson], Error>
    /// Get list of all wine positions with parameters
    func getAllWinePositionWithParameters(parameters: String) -> AnyPublisher<[WinePositionJson], Error>
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

    func getAllWinePosition() -> AnyPublisher<[WinePositionJson], Error> {
        request(endpoint: .getAllWinePosition())
    }

    func getAllWinePosition1() -> AnyPublisher<[WinePositionJson], Error> {
        request(endpoint: .getAllWinePosition1())
    }
    func getAllWinePositionWithParameters(parameters: String) -> AnyPublisher<[WinePositionJson], Error> {
        request(endpoint: .getAllWinePositionWithParameters())
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
    static func createWinePosition(_ form: WineJson.CreateForm) -> APICall {
        APICall(path: "/wine/position", method: "POST", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }

    static func deleteWinePosition(by id: String) -> APICall {
        APICall(path: "/wine/position/\(id)", method: "DELETE", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getAllWinePosition() -> APICall {
        APICall(path: "/wine/position", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getAllWinePosition1() -> APICall {
        APICall(path: "/wine/position", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getAllWinePositionWithParameters(parameters: String) -> APICall {
        APICall(path: "/wine/position/\(id)", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getWinePosition(by id: String) -> APICall {
        APICall(path: "/wine/position/\(id)", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func updateWinePosition(by id: String, with form: WineJson.UpdateForm) -> APICall {
        APICall(path: "/wine/position/\(id)", method: "PUT", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }
}
