//
//  View+spanned.swift
//  WineUp
//
//  Created by Александр Пахомов on 26.10.2020.
//

import SwiftUI

extension View {
    func horizontallySpanned(minSpace: CGFloat? = nil) -> some View {
        HStack {
            Spacer(minLength: minSpace)
            self
            Spacer(minLength: minSpace)
        }
    }

    func verticallySpanned(minSpace: CGFloat? = nil) -> some View {
        VStack {
            Spacer(minLength: minSpace)
            self
            Spacer(minLength: minSpace)
        }
    }
}
