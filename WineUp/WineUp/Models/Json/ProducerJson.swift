//
//  ProducerJson.swift
//  WineUp
//
//  Created by Влад on 06.11.2020.
//

import Foundation

struct ProducerJson: Decodable {
    var id: String
    var name: String
}

extension ProducerJson {
    struct CreateForm: Encodable {
        var name: String
    }

    struct UpdateForm: Encodable {
        var name: String
    }
}
