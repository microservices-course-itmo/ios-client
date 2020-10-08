//
//  Array+remove.swift
//  WineUp
//
//  Created by Александр Пахомов on 08.10.2020.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        removeAll(where: { $0 == element })
    }
}
