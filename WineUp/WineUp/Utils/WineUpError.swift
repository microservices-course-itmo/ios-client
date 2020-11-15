//
//  WineUpError.swift
//  WineUp
//
//  Created by Александр Пахомов on 02.11.2020.
//

import Foundation

enum WineUpError: Error {
    /// Unexpected WineUp data state
    case invalidAppState(_ description: String?)
    /// Unexpected flow
    case invalidState(_ description: String?)
    /// Method not implemented
    case notImplemented(_ file: String = #file, method: String = #function)
}
