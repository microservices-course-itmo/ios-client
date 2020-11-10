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

    func updateBrands(by id: String, with form: BrandJson.UpdateForm) -> AnyPublisher<[BrandJson], Error> {
        request(endpoint: .updateBrands(by: id, with: form))
    }

    func getBrandById(by id: String) -> AnyPublisher<BrandJson, Error> {
        request(endpoint: .getBrandById(by: id))
    }
}

// MARK: - Helpers

private extension APICall {
    static func createBrand(_ form: BrandJson.CreateForm) -> APICall {
        APICall(path: "/brand", method: "POST", headers: HTTPHeaders.empty.mockedAccessToken(), value: form)
    }

    static func updateBrands(by id: String, with form: BrandJson.UpdateForm) -> APICall {
        APICall(path: "/brand/\(id)", method: "PUT", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getAllBrands() -> APICall {
        APICall(path: "/brand", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }

    static func getBrandById(by id: String) -> APICall {
        APICall(path: "/brand/\(id)", method: "GET", headers: HTTPHeaders.empty.mockedAccessToken())
    }
}
