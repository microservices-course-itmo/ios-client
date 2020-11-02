//
//  Inputtable.swift
//  WineUp
//
//  Created by Александр Пахомов on 29.10.2020.
//

import Combine

// MARK: - Definition

enum Inputtable<T: Equatable>: Equatable {
    case notInputted(placeholder: T, updatesCounter: Int)
    case inputted(_ value: T, placeholder: T, updatesCounter: Int)
}

// MARK: - Helpers

extension Inputtable {
    init(placeholder: T) {
        self = .notInputted(placeholder: placeholder, updatesCounter: 0)
    }

    init(initialValue: T, placeholder: T? = nil) {
        let placeholder = placeholder ?? initialValue
        self = .inputted(initialValue, placeholder: placeholder, updatesCounter: 0)
    }

    /// If newValue == placeholder -> returns notInputted, optionally increases updates counter
    func nextValue(_ newValue: T) -> Inputtable<T> {
        var updatesCount = self.updatesCount

        if newValue == placeholder {
            // If changing from .value -> .notInputted
            if hasValue {
                updatesCount += 1
            }

            return .notInputted(placeholder: placeholder, updatesCounter: updatesCount)
        } else {
            // If either changing from .notInputted -> .value or just .value -> .value but with value update
            if value != newValue {
                updatesCount += 1
            }
            return .inputted(newValue, placeholder: placeholder, updatesCounter: updatesCount)
        }
    }

    /// Runs `nextValue` on self
    mutating func didInput(_ newValue: T) {
        self = nextValue(newValue)
    }

    var value: T? {
        switch self {
        case let .inputted(value, _, _):
            return value
        case .notInputted:
            return  nil
        }
    }

    var hasValue: Bool {
        value != nil
    }

    var placeholder: T {
        switch self {
        case let .inputted(_, placeholder, _):
            return placeholder
        case let .notInputted(placeholder, _):
            return placeholder
        }
    }

    var updatesCount: Int {
        switch self {
        case let .inputted(_, _, updatesCount):
            return updatesCount
        case let .notInputted(_, updatesCount):
            return updatesCount
        }
    }

    var hadUpdates: Bool {
        updatesCount > 0
    }
}

// MARK: - Useful Reactive Extensions

extension Publisher where Failure == Never {
    func unwrapInputtable<T>() -> Publishers.Map<Self, T> where Output == Inputtable<T> {
        map {
            switch $0 {
            case let .notInputted(placeholder, _):
                return placeholder
            case let .inputted(value, _, _):
                return value
            }
        }
    }

    /// Unwraps inputtable: returns either inputted value or placeholder
    func bindDisplayValue<V: Equatable, O: AnyObject>(
        _ mapKeyPath: KeyPath<Output, Inputtable<V>>,
        to object: O,
        by keyPath: ReferenceWritableKeyPath<O, V>
    ) -> AnyCancellable {
        map(mapKeyPath)
            .removeDuplicates()
            .unwrapInputtable()
            .assign(to: keyPath, on: object)
    }

    /// Runs `nextValue` on binded inputtable with new value
    func toInputtable<O: AnyObject>(
        of object: O,
        at keyPath: ReferenceWritableKeyPath<O, Inputtable<Output>>
    ) -> AnyCancellable where Output: Equatable {
        removeDuplicates()
            .map {
                object[keyPath: keyPath].nextValue($0)
            }
            .assign(to: keyPath, on: object)
    }
}
