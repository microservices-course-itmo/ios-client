//
//  UserJson.swift
//  WineUp
//
//  Created by Александр Пахомов on 14.11.2020.
//

import Foundation

struct UserJson: Decodable {
    var id: String
    var role: String
}

extension UserJson {
    struct LoginForm: Encodable {
        var fireBaseToken: FirebaseToken
    }

    struct LoginResponse: Decodable {
        var accessToken: AccessToken
        var refreshToken: RefreshToken
        var user: UserJson
    }

    struct RegistrationForm: Encodable {
        // TODO: Datetime format is missing
        var birthday: Date
        var cityId: Int
        var fireBaseToken: FirebaseToken
        var name: String
    }
}
