//
//  Common.swift
//  WineUp
//
//  Created by Александр Пахомов on 04.10.2020.
//

import Foundation

enum WineColor {
    case red, white, rose
}

enum WineAstringency {
    case dry, semiDry, semiSweet, sweet
}

// MARK: - Helpers

extension WineColor {
    // TODO: Create localize file with localization, can use Rswift for accessing it
    var name: String {
        switch self {
        case .red:
            return "Красное"
        case .white:
            return "Белое"
        case .rose:
            return "Розовое"
        }
    }
}

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
