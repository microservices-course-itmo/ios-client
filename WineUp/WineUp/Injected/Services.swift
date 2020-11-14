//
//  Services.swift
//  WineUp
//
//  Created by Александр Пахомов on 28.10.2020.
//

import Foundation

extension DIContainer {
    struct Services {
        let firebaseService: FirebaseService = RealFirebaseService()
    }
}
