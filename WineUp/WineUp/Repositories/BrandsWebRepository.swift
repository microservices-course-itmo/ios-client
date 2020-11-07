//
//  BrandsWebRepository.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 08.11.2020.
//

import Foundation
import Combine

// MARK: BrandsWebRepository

protocol BrandsWebRepository: WebRepository  {
    /// Create brand with data from form
    func createBrand(from form: BrandJson.CreateForm) -> AnyPublisher<Void, Error>
    /// Get list of all brands
    func getAllBrands() -> AnyPublisher<[BrandJson], Error>
    /// Get list of all brands1
    func getAllBrands1() -> AnyPublisher<[BrandJson], Error>
    /// Get brand by ID
    func getBrandById(by id: String) -> AnyPublisher<BrandJson, Error>
}

// MARK: - Implementation

final class RealBrandsWebRepository: BrandsWebRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func createBrand(from form: BrandJson.CreateForm) -> AnyPublisher<Void, Error> {
        call(endpoint: .createBrand(form))
    }

    func getAllBrands() -> AnyPublisher<[BrandJson], Error> {
        request(endpoint: .getAllBrands())
    }

    func getAllBrands1() -> AnyPublisher<[BrandJson], Error> {
        request(endpoint: .getAllBrands1())
    }

    func getBrandById(by id: String) -> AnyPublisher<BrandJson, Error> {
        request(endpoint: .getBrandById(by: id))
    }
}

// MARK: - Helpers

private extension APICall {
    static func createBrand(_ form: BrandJson.CreateForm) -> APICall {
        APICall(path: "/brands", method: "POST", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }

    static func getAllBrands() -> APICall {
        APICall(path: "/brands", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getAllBrands1() -> APICall {
        APICall(path: "/brands", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getBrandById(by id: String) -> APICall {
        APICall(path: "/brands/\(id)", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }
}
