//
//  LoginOneButtonContainer.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI

// MARK: - View

/// Login container for some View and one button like 'Submit'  below
struct LoginOneButtonContainer<Label: View>: View {

    let title: String
    let isButtonActive: Bool
    let buttonTitle: String
    let onButtonTap: () -> Void
    let label: () -> Label

    var body: some View {
        LoginContainer(title: title, viewLabel: label, actionLabel: {
            HStack {
                Spacer(minLength: 16)

                Button(action: onButtonTap) {
                    Text(buttonTitle)
                        .horizontallySpanned()
                }
                .defaultStyled(isDisabled: !isButtonActive)

                Spacer(minLength: 16)
            }
        })
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
