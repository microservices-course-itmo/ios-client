//
//  AuthCredentialsPersistanceRepository.swift
//  WineUp
//
//  Created by Александр Пахомов on 14.11.2020.
//

import Foundation
import SwiftKeychainWrapper

protocol AuthCredentialsPersistanceRepository: KeychainPersistanceRepository {
    var credentials: Credentials? { get set }
}

struct Credentials: Codable {
    var accessToken: AccessToken
    var refreshToken: RefreshToken
}

// MARK: - Implementation

final class RealAuthCredentialsPersistanceRepository: JsonKeychainPersistanceRepository<Credentials>,
    AuthCredentialsPersistanceRepository {

    init(wrapper: KeychainWrapper) {
        super.init(key: "authCredentials", wrapper: wrapper)
    }

    var credentials: Credentials? {
        get {
            value
        }
        set {
            value = newValue
        }
    }
}
