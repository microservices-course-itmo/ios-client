//
//  View+activity.swift
//  WineUp
//
//  Created by Александр Пахомов on 02.11.2020.
//

import SwiftUI

extension View {

    @ViewBuilder
    func activity(hasActivity: Bool, disableInteractionIfNeeded disableInteraction: Bool = true) -> some View {
        if hasActivity {
            self.overlay(ActivityIndicator().hoverEffect())
                .disabled(disableInteraction)
        } else {
            self
        }
    }
}
