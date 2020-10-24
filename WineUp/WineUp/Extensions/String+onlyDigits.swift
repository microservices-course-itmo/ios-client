//
//  String+onlyDigits.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import Foundation

extension String {
    var onlyDigits: String {
        filter( "0123456789".contains )
    }
}
