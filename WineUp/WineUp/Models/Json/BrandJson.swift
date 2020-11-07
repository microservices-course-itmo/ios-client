//
//  BrandJson.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 08.11.2020.
//

import Foundation

struct BrandJson: Decodable {
    var brandId: String
    var name: String
}

extension BrandJson {
    struct CreateForm {
        var name: String
    }
}
