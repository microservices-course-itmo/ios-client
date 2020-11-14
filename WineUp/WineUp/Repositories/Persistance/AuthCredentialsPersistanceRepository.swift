//
//  AuthCredentialsPersistanceRepository.swift
//  WineUp
//
//  Created by Александр Пахомов on 14.11.2020.
//

import Foundation

protocol AuthCredentialsPersistanceRepository: KeychainPersistanceRepository {
    var credentials: Credentials? { get set }
}

struct Credentials: Codable {
    var accessToken: String
    var refreshToken: String
}

// MARK: - Implementation

final class RealAuthCredentialsPersistanceRepository: JsonKeychainPersistanceRepository<Credentials>,
    AuthCredentialsPersistanceRepository {

    var credentials: Credentials? {
        get {
            value
        }
        set {
            value = newValue
        }
    }
}
