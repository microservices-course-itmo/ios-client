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

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 75, height: 75)
            .foregroundColor(Color.white)
            .background(Color.discountColor)
            .clipShape(Circle())
    }
}

// MARK: - Preview

#if DEBUG
struct CircleButtonStyle_Previews: PreviewProvider {
    static var previews: some View {

            Button("Title", action: {})
                .buttonStyle(CircleButtonStyle())
        .previewLayout(.fixed(width: 414, height: 120))
    }
}
#endif
