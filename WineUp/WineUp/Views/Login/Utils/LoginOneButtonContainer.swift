//
//  LoginOneButtonContainer.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let buttonHorizontalPadding: CGFloat = 35
    static let buttonCornerRadius: CGFloat = 25
}

private extension Color {
    static let activeButtonTitle = Color(.systemBackground)
    static let activeButtonBackground: Color = .blue
    static let disabledButtonTitle = Color(.label)
    static let disabledButtonBackground = Color(.systemGray4)
}

// MARK: - View

struct LoginOneButtonContainer<Label: View>: View {

    let title: String
    let isButtonActive: Bool
    let buttonTitle: String
    let onButtonTap: () -> Void
    let label: () -> Label

    var body: some View {
        LoginContainer(title: title, viewLabel: label, actionLabel: {
            Button(action: onButtonTap) {
                Text(buttonTitle)
            }
            .padding(.horizontal, .buttonHorizontalPadding)
            .padding(.vertical)
            .foregroundColor(buttonForegroundColor)
            .background(buttonBackgroundColor)
            .cornerRadius(.buttonCornerRadius)
        })
    }
}

// MARK: - Helpers

private extension LoginOneButtonContainer {
    var buttonForegroundColor: Color {
        isButtonActive ? .activeButtonTitle : .disabledButtonTitle
    }

    var buttonBackgroundColor: Color {
        isButtonActive ? .activeButtonBackground : .disabledButtonBackground
    }
}

// MARK: - Preview

#if DEBUG
struct LoginOneButtonContainer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginOneButtonContainer(title: "Title", isButtonActive: false, buttonTitle: "Button", onButtonTap: {}, label: {
                Text("ViewLabel")
            })

            LoginOneButtonContainer(title: "Title", isButtonActive: true, buttonTitle: "Button", onButtonTap: {}, label: {
                Text("ViewLabel")
            })
        }
    }
}
#endif
