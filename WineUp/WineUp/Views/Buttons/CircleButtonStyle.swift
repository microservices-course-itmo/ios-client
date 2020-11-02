//
//  CircleButtonStyle.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.11.2020.
//

import SwiftUI

// MARK: - Constants

private extension Color {
    static let enabledTitle: Color = .white
    static let enabledBackground = Color(red: 145 / 255, green: 22 / 255, blue: 52 / 255)
    static let disabledTitle: Color = .white
    static let disabledBackground = Color(.systemGray4)
}

// MARK: - ButtonStyle

struct CircleButtonStyle: ButtonStyle {

    let isDisabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: 70)
            .foregroundColor(titleColor)
            .background(backgroundColor)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .overlay(configuration.isPressed ? Color.white.opacity(0.15) : Color.clear)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
            .animation(.linear(duration: 0.1), value: isDisabled)
    }
}

// MARK: - Helpers

private extension CircleButtonStyle {
    var titleColor: Color {
        isDisabled ? .disabledTitle : .enabledTitle
    }

    var backgroundColor: Color {
        isDisabled ? .disabledBackground : .enabledBackground
    }
}

extension Button {
    func circleStyled(isDisabled: Bool = false) -> some View {
        self
            .buttonStyle(CircleButtonStyle(isDisabled: isDisabled))
            .disabled(isDisabled)
    }
}

// MARK: - Preview

#if DEBUG
struct CircleButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button("Title", action: {})
                .circleStyled(isDisabled: false)

            Button("Title", action: {})
                .circleStyled(isDisabled: true)
        }
        .previewLayout(.fixed(width: 414, height: 120))
    }
}
#endif
