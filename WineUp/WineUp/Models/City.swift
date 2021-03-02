//
//  City.swift
//  WineUp
//
//  Created by Александр Пахомов on 15.11.2020.
//

import SwiftUI

enum City: Int, CaseIterable, Identifiable, Codable {
    case notSelected = -1
    case saintPetersburg = 1
    case moscow = 2

    var id: Int { rawValue }

    static var displayCases: [City] {
        allCases.removing(.notSelected)
    }

    var titleName: LocalizedStringKey {
        switch self {
        case .saintPetersburg:
            return "Санкт-Петербург"
        case .moscow:
            return "Москва"
        default:
            assertionFailure()
            return ""
        }
    }
}
