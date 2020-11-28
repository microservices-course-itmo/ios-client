//
//  ProducerWebRepository.swift
//  WineUp
//
//  Created by Влад on 06.11.2020.
//

import Foundation
import Combine

// MARK: ProducerWebRepository

protocol ProducerWebRepository: WebRepository {
    /// Create Producer with data from form
    func createProducer(from form: ProducerJson.CreateForm) -> AnyPublisher<Void, Error>
    /// Get list of all Producers
    func getAllProducers() -> AnyPublisher<[ProducerJson], Error>
    /// Get Producer by id
    func getProducer(by id: String) -> AnyPublisher<ProducerJson, Error>
    /// Update Producer by id with data from form
    func updateProducer(by id: String, with form: ProducerJson.UpdateForm) -> AnyPublisher<Void, Error>
}

// MARK: - Implementation

final class RealProducerWebRepository: ProducerWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func createProducer(from form: ProducerJson.CreateForm) -> AnyPublisher<Void, Error> {
        call(endpoint: .createProducer(form))
    }

    func getAllProducers() -> AnyPublisher<[ProducerJson], Error> {
        request(endpoint: .getAllProducers())
    }

    func getProducer(by id: String) -> AnyPublisher<ProducerJson, Error> {
        request(endpoint: .getProducer(by: id))
    }

    func updateProducer(by id: String, with form: ProducerJson.UpdateForm) -> AnyPublisher<Void, Error> {
        call(endpoint: .updateProducer(by: id, with: form))
    }
}

// MARK: - Helpers

private extension APICall {
    static func createProducer(_ form: ProducerJson.CreateForm) -> APICall {
        APICall(path: "/producer", method: "POST", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }

    static func getAllProducers() -> APICall {
        APICall(path: "/producer", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getProducer(by id: String) -> APICall {
        APICall(path: "/producer/\(id)", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func updateProducer(by id: String, with form: ProducerJson.UpdateForm) -> APICall {
        APICall(path: "/producer/\(id)", method: "PUT", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }
}
