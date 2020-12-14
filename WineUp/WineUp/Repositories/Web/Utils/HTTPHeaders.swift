//
//  HTTPHeaders.swift
//  WineUp
//
//  Created by Александр Пахомов on 07.11.2020.
//

import Foundation

typealias HTTPHeaders = [String: String]

extension HTTPHeaders {
    static var empty: HTTPHeaders {
        [:]
    }

    func accessToken(_ accessToken: String) -> HTTPHeaders {
        updateValueWithCopy("Bearer \(accessToken)", forKey: .accessTokenHeader)
    }

    func contentType(_ contentType: String) -> HTTPHeaders {
        updateValueWithCopy(contentType, forKey: .contentType)
    }

    func jsonContentType() -> HTTPHeaders {
        contentType("application/json")
    }

    // TODO: Remove when real auth is intriduced
    func mockedAccessToken() -> HTTPHeaders {
        accessToken("123")
    }
}

// MARK: - Helpers

private extension Dictionary {
    func updateValueWithCopy(_ newValue: Value, forKey key: Key) -> Self {
        var copy = self
        copy.updateValue(newValue, forKey: key)
        return copy
    }
}

private extension String {
    static let accessTokenHeader = "Authorization"
    static let contentType = "Content-Type"
}
