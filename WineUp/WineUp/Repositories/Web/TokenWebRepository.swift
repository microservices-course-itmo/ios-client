//
//  TokenWebRepository.swift
//  WineUp
//
//  Created by Влад on 24.03.2021.
//

import Foundation
import Combine

// MARK: TokenWebRepository

protocol TokenWebRepository: WebRepository {
    func addAPNS(by tokenID: String) -> AnyPublisher<Void, Error>
}

// MARK: - Implementation

final class RealTokenWebRepository: TokenWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let credentials: Store<Credentials?>

    init(session: URLSession, baseURL: String, credentials: Store<Credentials?>) {
        self.session = session
        self.baseURL = baseURL
        self.credentials = credentials
    }

    func addAPNS(by tokenID: String) -> AnyPublisher<Void, Error> {
        call(endpoint: .addAPNS(by: tokenID))
    }
}

// MARK: - Helpers

private extension APICall {
    static func addAPNS(by tokenID: String) -> APICall {
        APICall(path: "/notification_tokens/", method: "POST", headers: HTTPHeaders.empty.mockedAccessToken(), parameters: [("token", tokenID), ("tokenType", "FCM_TOKEN")])
    }
}
