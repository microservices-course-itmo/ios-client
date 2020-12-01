//
//  Error+description.swift
//  WineUp
//
//  Created by Александр Пахомов on 02.12.2020.
//

import Foundation

extension Error {
    /// NSError bridging
    var ns: NSError {
        self as NSError
    }

    /// More informative description of error
    var description: String {
        ns.description
    }
}
