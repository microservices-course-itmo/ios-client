//
//  GrapeWebRepository.swift
//  WineUp
//
//  Created by Влад on 06.11.2020.
//

import Foundation
import Combine

// MARK: GrapeWebRepository

protocol GrapeWebRepository: WebRepository {
    /// Create grape with data from form
    func createGrape(from form: GrapeJson.CreateForm) -> AnyPublisher<Void, Error>
    /// Get list of all grapes
    func getAllGrapes() -> AnyPublisher<[GrapeJson], Error>
    /// Get grape by id
    func getGrape(by id: String) -> AnyPublisher<GrapeJson, Error>
    /// Update grape by id with data from form
    func updateGrape(by id: String, with form: GrapeJson.UpdateForm) -> AnyPublisher<Void, Error>
}

// MARK: - Implementation

final class RealGrapeWebRepository: GrapeWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let credentials: Store<Credentials?>

    init(session: URLSession, baseURL: String, credentials: Store<Credentials?>) {
        self.session = session
        self.baseURL = baseURL
        self.credentials = credentials
    }

    func createGrape(from form: GrapeJson.CreateForm) -> AnyPublisher<Void, Error> {
        call(endpoint: .createGrape(form))
    }

    func getAllGrapes() -> AnyPublisher<[GrapeJson], Error> {
        request(endpoint: .getAllGrapes())
    }

    func getGrape(by id: String) -> AnyPublisher<GrapeJson, Error> {
        request(endpoint: .getGrape(by: id))
    }

    func updateGrape(by id: String, with form: GrapeJson.UpdateForm) -> AnyPublisher<Void, Error> {
        call(endpoint: .updateGrape(by: id, with: form))
    }
}

// MARK: - Helpers

private extension APICall {
    static func createGrape(_ form: GrapeJson.CreateForm) -> APICall {
        APICall(path: "/grape", method: "POST", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }

    static func getAllGrapes() -> APICall {
        APICall(path: "/grape", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getGrape(by id: String) -> APICall {
        APICall(path: "/grape/\(id)", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func updateGrape(by id: String, with form: GrapeJson.UpdateForm) -> APICall {
        APICall(path: "/grape/\(id)", method: "PUT", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }
}
