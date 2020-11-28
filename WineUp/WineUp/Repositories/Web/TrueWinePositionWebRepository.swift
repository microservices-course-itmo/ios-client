//
//  TrueWinePositionWebRepository.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.11.2020.
//

import Foundation
import Combine

// MARK: - TrueWinePositionWebRepository

protocol TrueWinePositionWebRepository: WebRepository {
    func getAllTrueWinePositions() -> AnyPublisher<[TrueWinePositionJson], Error>
}

// MARK: - Implementation

final class RealTrueWinePositionWebRepository: TrueWinePositionWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func getAllTrueWinePositions() -> AnyPublisher<[TrueWinePositionJson], Error> {
        request(endpoint: .getAllTrueWinePositions())
    }
}

// MARK: - Helpers

private extension APICall {
    static func getAllTrueWinePositions() -> APICall {
        APICall(path: "/position/true/", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }
}
