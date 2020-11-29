//
//  Date+Extensions.swift
//  WineUp
//
//  Created by Александр Пахомов on 29.10.2020.
//

import Foundation

extension Date {
    func plus(_ components: DateComponents) -> Date {
        guard let date = Calendar.current.date(byAdding: components, to: self) else {
            assertionFailure("Unknown DATE fucking error?!? Shit dick motherfucker suck my ass")
            return self
        }
        return date
    }

    func getDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}
