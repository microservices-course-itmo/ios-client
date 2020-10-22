//
//  LoginOneButtonContainer.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI

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
            .padding(.horizontal, 35)
            .padding(.vertical)
            .foregroundColor(buttonForegroundColor)
            .background(buttonBackgroundColor)
            .cornerRadius(25)
        })
    }
}

private extension LoginOneButtonContainer {
    var buttonForegroundColor: Color {
        isButtonActive ? Color(.systemBackground) : Color(.label)
    }

    var buttonBackgroundColor: Color {
        isButtonActive ? .blue : Color(.systemGray4)
    }
}

#if DEBUG
//struct LoginOneButtonContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginOneButtonContainer()
//    }
//}
#endif
