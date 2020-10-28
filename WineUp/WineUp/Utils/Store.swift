//
//  Store.swift
//  WineUp
//
//  Created by Александр Пахомов on 28.10.2020.
//

import Combine
import SwiftUI

typealias Store<State> = CurrentValueSubject<State, Never>

extension Store {

    subscript<T>(keyPath: WritableKeyPath<Output, T>) -> T where T: Equatable {
        get { value[keyPath: keyPath] }
        set {
            var value = self.value
            if value[keyPath: keyPath] != newValue {
                value[keyPath: keyPath] = newValue
                self.value = value
            }
        }
    }

    func bulkUpdate(_ update: (inout Output) -> Void) {
        var value = self.value
        update(&value)
        self.value = value
    }

    func updates<Value>(for keyPath: KeyPath<Output, Value>) ->
        AnyPublisher<Value, Failure> where Value: Equatable {
        return map(keyPath).removeDuplicates().eraseToAnyPublisher()
    }
}

// MARK: - Helpers

extension ObservableObject {
    func loadableSubject<Value>(_ keyPath: WritableKeyPath<Self, Loadable<Value>>) -> LoadableSubject<Value> {
        let defaultValue = self[keyPath: keyPath]
        return .init(get: { [weak self] in
            self?[keyPath: keyPath] ?? defaultValue
        }, set: { [weak self] in
            self?[keyPath: keyPath] = $0
        })
    }
}

extension Binding {
    typealias ValueClosure = (Value) -> Void

    func onSet(_ perform: @escaping ValueClosure) -> Self {
        return .init(get: { () -> Value in
            self.wrappedValue
        }, set: { value in
            self.wrappedValue = value
            perform(value)
        })
    }
}

extension Store where Failure == Never {
    /// Creates bidirectional connection from Store's field to object's one and from publisher to Store's field
    func biAssign<V: Equatable, P: Publisher, O>(
        _ valueKeyPath: WritableKeyPath<Output, V>,
        to object: O,
        on keyPath: ReferenceWritableKeyPath<O, V>,
        publisher: P
    ) -> [AnyCancellable] where P.Failure == Never, P.Output == V {
        return [
            publisher
                .removeDuplicates()
                .sink(receiveValue: { [weak self] value in
                self?.value[keyPath: valueKeyPath] = value
            }),

            map(valueKeyPath)
                .assign(to: keyPath, on: object)
        ]
    }
}
