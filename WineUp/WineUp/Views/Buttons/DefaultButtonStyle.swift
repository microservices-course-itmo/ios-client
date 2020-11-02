//
//  DefaultButtonStyle.swift
//  WineUp
//
//  Created by Александр Пахомов on 26.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let horizontalPadding: CGFloat = 35
    static let cornerRadius: CGFloat = 12
}

private extension Color {
    static let enabledTitle = Color(.systemBackground)
    static let enabledBackground: Color = .blue
    static let disabledTitle = Color(.label)
    static let disabledBackground = Color(.systemGray4)
}

// MARK: - ButtonStyle

/// Applies default style to button. Note: style does not toggle interaction flag
struct DefaultButtonStyle: ButtonStyle {
    let isDisabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, .horizontalPadding)
            .padding(.vertical)
            .foregroundColor(titleColor)
            .background(backgroundColor)
            .cornerRadius(.cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
            .overlay(configuration.isPressed ? Color.white.opacity(0.1) : Color.clear)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
            .animation(.linear(duration: 0.1), value: isDisabled)
    }
}

// MARK: - Helpers

private extension DefaultButtonStyle {
    var titleColor: Color {
        isDisabled ? .disabledTitle : .enabledTitle
    }

    var backgroundColor: Color {
        isDisabled ? .disabledBackground : .enabledBackground
    }
}

// MARK: - Button+defaultStyled

extension Button {
    /// Applies default style to button and toggles its interaction flag
    func defaultStyled(isDisabled: Bool) -> some View {
        self
            .buttonStyle(DefaultButtonStyle(isDisabled: isDisabled))
            .disabled(isDisabled)
    }
}

// MARK: - Preview

struct DefaultButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button("Title", action: {})
                .buttonStyle(DefaultButtonStyle(isDisabled: false))

            Button("Title", action: {})
                .buttonStyle(DefaultButtonStyle(isDisabled: true))
        }
        .previewLayout(.fixed(width: 414, height: 120))
    }
}
