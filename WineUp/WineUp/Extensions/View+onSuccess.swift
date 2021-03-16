//
//  View+onSuccess.swift
//  WineUp
//
//  Created by Александр Пахомов on 01.03.2021.
//

import SwiftUI

extension View {
    func onSuccess<T>(_ loadable: Loadable<T>, perform block: @escaping () -> Void) -> some View {
        self
            .overlay(
                performView(doPerform: loadable.value != nil, block: block)
            )
    }

    /// Performs block if `doPerform` usign `Color.clear.onAppear`
    @ViewBuilder
    func performView(doPerform: Bool, block: @escaping () -> Void) -> some View {
        if doPerform {
            Color.clear
                .frame(width: 0, height: 0)
                .onAppear(perform: block)
        } else {
            EmptyView()
                .frame(width: 0, height: 0)
        }
    }
}
