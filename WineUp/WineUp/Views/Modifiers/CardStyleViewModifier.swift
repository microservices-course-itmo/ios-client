//
//  CardStyleViewModifier.swift
//  WineUp
//
//  Created by Александр Пахомов on 02.11.2020.
//

import SwiftUI

// MARK: - ViewModifier

struct CardStyleViewModifier: ViewModifier {

    let cornerRadius: CGFloat
    let borderColor: Color
    let shadowColor: Color
    let shadowRadius: CGFloat

    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemBackground))
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: 1)
                )
                .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: 0)

            content
                .cornerRadius(cornerRadius)
        }
    }
}

// MARK: - Helpers

extension View {
    func cardStyled(
        cornerRadius: CGFloat = 15,
        borderColor: Color = Color(.label).opacity(0.1),
        shadowColor: Color = Color(.label).opacity(0.1),
        shadowRadius: CGFloat = 16
    ) -> some View {
        self
            .modifier(
                CardStyleViewModifier(
                    cornerRadius: cornerRadius,
                    borderColor: borderColor,
                    shadowColor: shadowColor,
                    shadowRadius: shadowRadius
                )
            )
    }
}

// MARK: - Preview

#if DEBUG
struct CardStyleViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Color.red
            .cardStyled()
            .padding()
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
#endif
