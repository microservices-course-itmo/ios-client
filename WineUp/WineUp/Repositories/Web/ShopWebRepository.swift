//
//  ShowWebRepository.swift
//  WineUp
//
//  Created by Александр Пахомов on 17.11.2020.
//

import Foundation
import Combine

// MARK: ShopWebRepository

protocol ShopWebRepository: WebRepository {
    /// Get list of all shops
    func getAllShops() -> AnyPublisher<[ShopJson], Error>
    /// Get shop by id
    func getShop(by id: String) -> AnyPublisher<ShopJson, Error>
}

// MARK: - Implementation

final class RealShopWebRepository: ShopWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let credentials: Store<Credentials?>

    init(session: URLSession, baseURL: String, credentials: Store<Credentials?>) {
        self.session = session
        self.baseURL = baseURL
        self.credentials = credentials
    }

    func getAllShops() -> AnyPublisher<[ShopJson], Error> {
        request(endpoint: .getAllShops())
    }

    func getShop(by id: String) -> AnyPublisher<ShopJson, Error> {
        request(endpoint: .getShop(by: id))
    }
}

// MARK: - Helpers

private extension APICall {
    static func getAllShops() -> APICall {
        APICall(path: "/shop", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getShop(by id: String) -> APICall {
        APICall(path: "/shop/\(id)", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }
}
