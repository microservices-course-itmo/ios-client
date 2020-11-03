//
//  APICall.swift
//  WineUp
//
//  Created by Александр Пахомов on 03.11.2020.
//

import Foundation

struct APICall {
    var path: String
    var method: String
    var headers: [String: String]?
    var body: () throws -> Data?

    init(
        path: String,
        method: String,
        headers: [String: String]? = nil,
        body: @autoclosure @escaping () throws -> Data? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.body = body
    }

    init<Value>(
        path: String,
        method: String,
        headers: [String: String]? = nil,
        value: @autoclosure @escaping () throws -> Value
    ) where Value: Encodable {
        self.path = path
        self.method = method
        self.headers = headers
        self.body = {
            let value = try value()
            return try JSONEncoder.snakeCaseCompatible().encode(value)
        }
    }
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

private extension JSONEncoder {
    static func snakeCaseCompatible() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}
