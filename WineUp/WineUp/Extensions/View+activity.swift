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

    func activity(triggers: [ActivityTrigger]) -> some View {
        let activityNeeded = triggers.contains(where: { $0.triggersActivity() })
        return self.activity(hasActivity: activityNeeded)
    }

    func activity(triggers: ActivityTrigger...) -> some View {
        activity(triggers: triggers)
    }
}

protocol ActivityTrigger {
    func triggersActivity() -> Bool
}

extension Loadable: ActivityTrigger {
    func triggersActivity() -> Bool {
        if case .isLoading = self {
            return true
        }
        return false
    }
}
