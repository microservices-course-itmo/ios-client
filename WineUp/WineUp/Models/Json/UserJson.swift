//
//  UserJson.swift
//  WineUp
//
//  Created by Александр Пахомов on 14.11.2020.
//

import Foundation

struct UserJson: Decodable {
    var id: String
    var birthdate: String
    var city: City
    var name: String
    var phoneNumber: String
    var role: String

    enum CodingKeys: String, CodingKey {
        case id
        case birthdate
        case city = "cityId"
        case name
        case phoneNumber
        case role
    }
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
        var birthday: LocalDate
        var cityId: Int
        var fireBaseToken: FirebaseToken
        var name: String
    }

    struct UpdateForm: Encodable {
        var cityId: Int?
        var phoneNumber: String?
    }
}
