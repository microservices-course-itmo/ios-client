//
//  View+activity.swift
//  WineUp
//
//  Created by Александр Пахомов on 02.11.2020.
//

import SwiftUI

extension View {
    func activity(hasActivity: Bool, disableInteractionIfNeeded disableInteraction: Bool = true) -> some View {
        if hasActivity {
            return self
                .overlay(
                    ActivityIndicator()
                        .hoverEffect()
                )
                .disabled(disableInteraction)
                .anyView
        } else {
            return self.anyView
        }
    }
}
