//
//  WebRepository.swift
//  WineUp
//
//  Created by Александр Пахомов on 03.11.2020.
//

import Foundation
import Combine

protocol WebRepository: Repository {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
    var credentials: Store<Credentials?> { get }
}

extension WebRepository {
    private typealias DataTaskResponse = URLSession.DataTaskPublisher.Output
    private typealias DataTaskFailure = URLSession.DataTaskPublisher.Failure

    func accessTokenPublisher() -> AnyPublisher<AccessToken, Error> {
        if let token = credentials.value?.accessToken {
            return Just<AccessToken>.withErrorType(token, Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail<AccessToken, Error>(error: WineUpError.notAuthenticated)
                .eraseToAnyPublisher()
        }
    }

    private func dataTask(to endpoint: APICall, httpCodes: HTTPCodes)
    throws -> AnyPublisher<DataTaskResponse, DataTaskFailure> {
        let request = try endpoint.urlRequest(baseURL: baseURL)
        let timeStart = Date()
        return session
            .dataTaskPublisher(for: request)
            .map { response -> DataTaskResponse in
                let timeEnd = Date()
                self.log(request: request, response: response, duration: timeEnd.timeIntervalSince(timeStart))
                return response
            }
            .eraseToAnyPublisher()
    }

    private func log(request: URLRequest, response: DataTaskResponse, duration: TimeInterval) {
        var string = "\n" + request.wineUpDescription

        if let httpResponse = response.response as? HTTPURLResponse {
            string += "\n" + httpResponse.wineUpDescription
        }

        if let responseData = String(data: response.data, encoding: .utf8) {
            string += "\n\tData:  \(responseData)\n"
        }

        string += String(format: "\tDuration: %4.2fs", duration)

        print(string)
    }

    /// Executes URLRequest and decodes JSON from body
    func request<Value>(
        endpoint: APICall,
        httpCodes: HTTPCodes = .success
    ) -> AnyPublisher<Value, Error> where Value: Decodable {
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

private extension URLRequest {
    var wineUpDescription: String {
        """
        ➡️ \(self.httpMethod ?? "#error_method") \(self.url?.absoluteString ?? "#error_url")
            Headers: \(self.allHTTPHeaderFields ?? [:])
            Body:    \(self.httpBody.flatMap { String(data: $0, encoding: .utf8) ?? "#error_data" } ?? "#empty")
        """
    }
}

private extension HTTPURLResponse {
    var wineUpDescription: String {
        let headersList = allHeaderFields.map { header in
            (header.key as? String, header.value)
        }
        let headers = Dictionary(uniqueKeysWithValues: headersList) as? [String: Any]

        return """
        ⬅️ Response \(self.statusCode) \(self.statusCode != 200 ? "⚠️" : "")
            Headers: \(headers?.description ?? "#error")
        """
    }
}
