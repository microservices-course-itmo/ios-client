//
//  View+onError.swift
//  WineUp
//
//  Created by Александр Пахомов on 14.03.2021.
//

import SwiftUI

extension View {
    func onError<T>(_ loadable: Loadable<T>, perform block: @escaping () -> Void) -> some View {
        self
            .overlay(
                performView(doPerform: loadable.error != nil, block: block)
            )
    }
}
