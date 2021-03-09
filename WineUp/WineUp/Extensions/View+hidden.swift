//
//  View+hidden.swift
//  WineUp
//
//  Created by Александр Пахомов on 09.03.2021.
//

import SwiftUI

extension View {
    /// Optionally hides view
    @ViewBuilder
    func hidden(_ hidden: Bool) -> some View {
        if hidden {
            self
                .hidden()
        } else {
            self
        }
    }
}
