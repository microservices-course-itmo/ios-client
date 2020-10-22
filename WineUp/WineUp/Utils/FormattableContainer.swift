//
//  FormattableContainer.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import Foundation

struct FormattableContainer<Value> {
    var value: Value {
        didSet {
            if doFormatOnSet {
                format()
            } else {
                onChange?(value)
            }
        }
    }

    private var doFormatOnSet = true
    private let formatter: (Value) -> Value
    private let onChange: ((Value) -> Void)?

    init(_ initialValue: Value, formatter: @escaping (Value) -> Value, onChange: ((Value) -> Void)? = nil) {
        self.value = initialValue
        self.formatter = formatter
        self.onChange = onChange
    }

    private mutating func format() {
        doFormatOnSet = false
        value = formatter(value)
        doFormatOnSet = true
    }
}
