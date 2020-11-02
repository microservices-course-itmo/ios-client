//
//  CircleButtonStyle.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.11.2020.
//

import SwiftUI

// MARK: - Constants

private extension Color {
    static let discountColor = Color(red: 145 / 255, green: 22 / 255, blue: 52 / 255)
}

// MARK: - ButtonStyle

struct CircleButtonStyle: ButtonStyle {

    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 75, height: 75)
            .foregroundColor(Color.white)
            .background(color)
            .clipShape(Circle())
    }
}

// MARK: - Helpers

extension Button {
    func circleStyled(color: Color = .discountColor) -> some View {
        self
            .buttonStyle(CircleButtonStyle(color: color))
    }
}

// MARK: - Preview

#if DEBUG
struct CircleButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Title", action: {})
            .circleStyled()
            .previewLayout(.fixed(width: 414, height: 120))
    }
}
#endif
