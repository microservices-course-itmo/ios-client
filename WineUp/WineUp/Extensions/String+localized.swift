//
//  String+localized.swift
//  WineUp
//
//  Created by Александр Пахомов on 05.10.2020.
//

import Foundation

extension String {
    func localized(withComment comment: String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: .main, value: "", comment: comment)
    }
}
