//
//  QueryParameters.swift
//  WineUp
//
//  Created by Александр Пахомов on 27.11.2020.
//

import Foundation

typealias QueryParameter = (String, String)
typealias QueryParameters = [QueryParameter]

extension URLComponents {
    init?(string: String, queryItems: [URLQueryItem]) {
        self.init(string: string)
        self.queryItems = queryItems
    }

    init?(string: String, queryParameters: QueryParameters) {
        self.init(string: string, queryItems: queryParameters.map { URLQueryItem(name: $0.0, value: $0.1) })
    }
}
