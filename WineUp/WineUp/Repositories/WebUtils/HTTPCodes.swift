//
//  HTTPCodes.swift
//  WineUp
//
//  Created by Александр Пахомов on 03.11.2020.
//

import Foundation

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
