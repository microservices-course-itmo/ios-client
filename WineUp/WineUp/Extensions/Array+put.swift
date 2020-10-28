//
//  Array+put.swift
//  WineUp
//
//  Created by Александр Пахомов on 28.10.2020.
//

import Combine

extension Array where Element == AnyCancellable {
    func put(in bag: CancelBag) {
        bag.collect(contentsOf: self)
    }
}
