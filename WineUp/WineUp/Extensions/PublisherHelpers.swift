//
//  PublisherHelpers.swift
//  WineUp
//
//  Created by Александр Пахомов on 27.11.2020.
//

import Combine

extension Publisher {
    /// Executes block when value comes
    func pass(_ block: @escaping (Output) -> Void) -> AnyPublisher<Output, Failure> {
        map { output -> Output in
            block(output)
            return output
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher where Failure == Never {
    /// Executes lambda only when the value changes
    func onChange(_ onChange: @escaping (Output) -> Void) -> AnyCancellable where Output: Equatable {
        removeDuplicates()
            .sink(receiveValue: onChange)
    }

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
