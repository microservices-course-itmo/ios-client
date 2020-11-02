//
//  Publisher+onChange.swift
//  WineUp
//
//  Created by Александр Пахомов on 02.11.2020.
//

import Combine

extension Publisher where Failure == Never {
    /// Executes lambda only when the value changes
    func onChange(_ onChange: @escaping (Output) -> Void) -> AnyCancellable where Output: Equatable {
        removeDuplicates()
            .sink(receiveValue: onChange)
    }
}
