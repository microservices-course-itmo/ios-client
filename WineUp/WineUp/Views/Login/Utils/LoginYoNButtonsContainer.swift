//
//  LoginYoNButtonsContainer.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let buttonsSpacing: CGFloat = 24
    static let buttonHorizontalPadding: CGFloat = 35
    static let buttonCornerRadius: CGFloat = 25
}

private extension Color {
    static let buttonTitle: Color = .white
    static let buttonBackground: Color = .blue
}

private extension Font {
    static let buttonTitle = Font.body.bold()
}

// MARK: - View

struct LoginYoNButtonsContainer<Label: View>: View {

    let title: String
    let yesButtonTitle: String
    let noButtonTitle: String
    let onYesButtonTap: () -> Void
    let onNoButtonTap: () -> Void
    let label: () -> Label

    var body: some View {
        LoginContainer(title: title, viewLabel: label, actionLabel: {
            HStack(alignment: .center, spacing: .buttonsSpacing) {
                Button(action: onYesButtonTap) {
                    Text(yesButtonTitle)
                }
                .padding(.horizontal, .buttonHorizontalPadding)
                .padding(.vertical)
                .foregroundColor(.buttonTitle)
                .background(Color.buttonBackground)
                .font(.buttonTitle)
                .cornerRadius(.buttonCornerRadius)

                Button(action: onNoButtonTap) {
                    Text(noButtonTitle)
                }
                .padding(.horizontal, .buttonHorizontalPadding)
                .padding(.vertical)
                .foregroundColor(.buttonTitle)
                .background(Color.buttonBackground)
                .font(.buttonTitle)
                .cornerRadius(.buttonCornerRadius)
            }
        })
    }
}

// MARK: - Preview

#if DEBUG
struct LoginYoNButtonsContainer_Previews: PreviewProvider {
    static var previews: some View {
        LoginYoNButtonsContainer(
            title: "Title",
            yesButtonTitle: "Yes",
            noButtonTitle: "No",
            onYesButtonTap: {},
            onNoButtonTap: {},
            label: {
                Text("ViewLabel")
            }
        )
    }
}
#endif
