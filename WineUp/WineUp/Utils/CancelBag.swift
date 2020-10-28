//
//  CancelBag.swift
//  WineUp
//
//  Created by Александр Пахомов on 28.10.2020.
//

import Combine

final class CancelBag {
    var subscriptions = Set<AnyCancellable>()

    func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }

    func collect(@Builder _ cancellables: () -> [AnyCancellable]) {
        collect(contentsOf: cancellables())
    }

    func collect(contentsOf cancellables: [AnyCancellable]) {
        subscriptions.formUnion(cancellables)
    }

    @_functionBuilder
    struct Builder {
        static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
            return cancellables
        }
    }
}

extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
