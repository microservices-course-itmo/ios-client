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
}

// MARK: - View

/// Login container for some View and two buttons below
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
                Spacer()

                Button(action: onYesButtonTap) {
                    Text(yesButtonTitle)
                        .horizontallySpanned()
                }
                .defaultStyled(isDisabled: false)

                Button(action: onNoButtonTap) {
                    Text(noButtonTitle)
                        .horizontallySpanned()
                }
                .defaultStyled(isDisabled: false)

                Spacer()
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
