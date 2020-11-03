//
//  WebRepository.swift
//  WineUp
//
//  Created by Александр Пахомов on 03.11.2020.
//

import Foundation
import Combine

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
}

extension WebRepository {
    private func dataTask(to endpoint: APICall, httpCodes: HTTPCodes) throws -> URLSession.DataTaskPublisher {
        let request = try endpoint.urlRequest(baseURL: baseURL)
        return session
            .dataTaskPublisher(for: request)
    }

    /// Executes URLRequest and decodes JSON from body
    func request<Value>(endpoint: APICall, httpCodes: HTTPCodes = .success) -> AnyPublisher<Value, Error> where Value: Decodable {
        do {
            return try dataTask(to: endpoint, httpCodes: httpCodes)
                .request(httpCodes: httpCodes)
        } catch {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }

    /// Executes URLRequest
    func call(endpoint: APICall, httpCodes: HTTPCodes = .success) -> AnyPublisher<Void, Error> {
        do {
            return try dataTask(to: endpoint, httpCodes: httpCodes)
                .call(httpCodes: httpCodes)
        } catch {
            return Fail<Void, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: - Helpers

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    private static func check(response: URLResponse, with httpCodes: HTTPCodes) throws {
        assert(!Thread.isMainThread)

        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw APIError.unexpectedResponse
        }

        guard httpCodes.contains(code) else {
            throw APIError.httpCode(code)
        }
    }

    func request<Value>(httpCodes: HTTPCodes) -> AnyPublisher<Value, Error> where Value: Decodable {
        tryMap { data, response -> Data in
            try Self.check(response: response, with: httpCodes)
            return data
        }
        .extractUnderlyingError()
        .decode(type: Value.self, decoder: JSONDecoder.snakeCaseCompatible())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    func call(httpCodes: HTTPCodes) -> AnyPublisher<Void, Error> {
        tryMap { _, response -> Void in
            try Self.check(response: response, with: httpCodes)
        }
        .extractUnderlyingError()
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

private extension JSONDecoder {
    static func snakeCaseCompatible() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
