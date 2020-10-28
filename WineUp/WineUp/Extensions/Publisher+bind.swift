//
//  Publisher+bind.swift
//  WineUp
//
//  Created by Александр Пахомов on 28.10.2020.
//

import Combine

extension Publisher where Failure == Never {
    /// Assign with removing duplicates
    func bind<V: Equatable, O: AnyObject>(
        _ mapKeyPath: KeyPath<Output, V>,
        to object: O,
        by keyPath: ReferenceWritableKeyPath<O, V>
    ) -> AnyCancellable {
        map(mapKeyPath)
            .removeDuplicates()
            .assign(to: keyPath, on: object)
    }

    /// Assign with removing duplicates
    func bind<O: AnyObject>(
        to object: O,
        by keyPath: ReferenceWritableKeyPath<O, Output>
    ) -> AnyCancellable where Output: Equatable {
        removeDuplicates()
            .assign(to: keyPath, on: object)
    }
}
