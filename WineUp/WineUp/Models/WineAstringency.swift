//
//  WineAstringency.swift
//  WineUp
//
//  Created by Александр Пахомов on 05.10.2020.
//

import Foundation

enum WineAstringency {
    case dry, semiDry, semiSweet, sweet
}

// MARK: - Helpers

extension WineAstringency {
    // TODO: Create localize file with localization, can use Rswift for accessing it
    var name: String {
        switch self {
        case .dry:
            return "Сухое"
        case .semiDry:
            return "Полусухое"
        case .semiSweet:
            return "Полусладкое"
        case .sweet:
            return "Сладкое"
        }
    }
}

extension WineJson.Sugar {
    var astringency: WineAstringency {
        switch self {
        case .dry:
            return .dry
        case .semiDry:
            return .semiDry
        case .semiSweet:
            return .semiSweet
        case .sweet:
            return .sweet
        }
    }
}
