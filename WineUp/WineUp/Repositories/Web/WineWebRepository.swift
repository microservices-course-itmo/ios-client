//
//  WineWebRepository.swift
//  WineUp
//
//  Created by Александр Пахомов on 03.11.2020.
//

import Foundation
import Combine

// MARK: WineWebRepository

protocol WineWebRepository: WebRepository {
    /// Create wine with data from form
    func createWine(from form: WineJson.CreateForm) -> AnyPublisher<Void, Error>
    /// Delete wine by id
    func deleteWine(by id: String) -> AnyPublisher<Void, Error>
    /// Get list of all wines
    func getAllWines() -> AnyPublisher<[WineJson], Error>
    /// Get wine by id
    func getWine(by id: String) -> AnyPublisher<WineJson, Error>
    /// Update wine by id with data from form
    func updateWine(by id: String, with form: WineJson.UpdateForm) -> AnyPublisher<Void, Error>
}

// MARK: - Implementation

final class RealWineWebRepository: WineWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let credentials: Store<Credentials?>

    init(session: URLSession, baseURL: String, credentials: Store<Credentials?>) {
        self.session = session
        self.baseURL = baseURL
        self.credentials = credentials
    }

    func createWine(from form: WineJson.CreateForm) -> AnyPublisher<Void, Error> {
        call(endpoint: .createWine(form))
    }

    func deleteWine(by id: String) -> AnyPublisher<Void, Error> {
        call(endpoint: .deleteWine(by: id))
    }

    func getAllWines() -> AnyPublisher<[WineJson], Error> {
        request(endpoint: .getAllWines())
    }

    func getWine(by id: String) -> AnyPublisher<WineJson, Error> {
        request(endpoint: .getWine(by: id))
    }

    func updateWine(by id: String, with form: WineJson.UpdateForm) -> AnyPublisher<Void, Error> {
        call(endpoint: .updateWine(by: id, with: form))
    }
}

// MARK: - Helpers

private extension APICall {
    static func createWine(_ form: WineJson.CreateForm) -> APICall {
        APICall(path: "/wine", method: "POST", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }

    static func deleteWine(by id: String) -> APICall {
        APICall(path: "/wine/\(id)", method: "DELETE", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getAllWines() -> APICall {
        APICall(path: "/wine", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getWine(by id: String) -> APICall {
        APICall(path: "/wine/\(id)", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func updateWine(by id: String, with form: WineJson.UpdateForm) -> APICall {
        APICall(path: "/wine/\(id)", method: "PUT", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }
}
