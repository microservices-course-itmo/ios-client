//
//  View+onSuccess.swift
//  WineUp
//
//  Created by Александр Пахомов on 01.03.2021.
//

import SwiftUI

extension View {
    func onSuccess<T>(_ loadable: Loadable<T>, perform block: @escaping () -> Void) -> some View {
        if loadable.value != nil {
            block()
        }
        return self
    }
}
