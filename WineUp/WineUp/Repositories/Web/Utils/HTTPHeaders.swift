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
        updateValueWithCopy(accessToken, forKey: .accessTokenHeader)
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
    static let accessTokenHeader = "accessToken"
}
