//
//  Date+plus.swift
//  WineUp
//
//  Created by Александр Пахомов on 29.10.2020.
//

import Foundation

extension Date {
    func plus(_ components: DateComponents) -> Date {
        guard let date = Calendar.current.date(byAdding: components, to: self) else {
            assertionFailure("Unknown DATE fucking error?!?")
            return self
        }
        return date
    }
}
