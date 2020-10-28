//
//  Inversible.swift
//  WineUp
//
//  Created by Александр Пахомов on 29.10.2020.
//

import Combine

protocol Inversible {
    func inversed() -> Self
}

extension Publisher where Failure == Never, Output: Inversible {
    func toggle() -> Publishers.Map<Self, Output> {
        map {
            $0.inversed()
        }
    }
}

extension Bool: Inversible {
    func inversed() -> Bool {
        !self
    }
}
