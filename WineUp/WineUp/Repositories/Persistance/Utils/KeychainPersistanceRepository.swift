//
//  KeychainPersistanceRepository.swift
//  WineUp
//
//  Created by Александр Пахомов on 14.11.2020.
//

import Foundation
import SwiftKeychainWrapper

/// Persistance repository which uses `KeychainWrapper` (secure persistant container) for storing data
protocol KeychainPersistanceRepository: PersistanceRepository {
    var key: String { get }
    var wrapper: KeychainWrapper { get }
}

extension KeychainPersistanceRepository {
    func save(data: Data?) {
        if let data = data {
            wrapper.set(data, forKey: key)
        } else {
            wrapper.removeObject(forKey: key)
        }
    }

    func retrieveData() -> Data? {
        wrapper.data(forKey: key)
    }
}
