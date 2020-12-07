//
//  Data+hexString.swift
//  WineUp
//
//  Created by Александр Пахомов on 07.12.2020.
//

import Foundation

extension Data {
    var hexString: String {
        map {
            String(format: "%02hhX", $0)
        }
        .joined()
    }
}
