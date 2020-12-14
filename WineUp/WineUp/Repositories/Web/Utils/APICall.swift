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
    var headers: HTTPHeaders?
    var parameters: QueryParameters
    var body: () throws -> Data?

    init(
        path: String,
        method: String,
        headers: HTTPHeaders? = nil,
        parameters: QueryParameters = [],
        body: @autoclosure @escaping () throws -> Data? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.body = body
    }

    init<Value>(
        path: String,
        method: String,
        headers: HTTPHeaders? = nil,
        parameters: QueryParameters = [],
        value: @autoclosure @escaping () throws -> Value,
        encodingStratagy: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase
    ) where Value: Encodable {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = (headers ?? [:]).jsonContentType()
        self.parameters = parameters
        self.body = {
            let value = try value()
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = encodingStratagy
            return try encoder.encode(value)
        }
    }
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URLComponents(string: baseURL + path, queryParameters: parameters)?.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}
