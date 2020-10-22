//
//  LoginYoNButtonsContainer.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI

struct LoginYoNButtonsContainer<Label: View>: View {

    let title: String
    let yesButtonTitle: String
    let noButtonTitle: String
    let onYesButtonTap: () -> Void
    let onNoButtonTap: () -> Void
    let label: () -> Label

    var body: some View {
        LoginContainer(title: title, viewLabel: label, actionLabel: {
            HStack(alignment: .center, spacing: 24) {
                Button(action: onYesButtonTap) {
                    Text(yesButtonTitle)
                }
                .padding(.horizontal, 35)
                .padding(.vertical)
                .foregroundColor(.white)
                .background(Color.blue)
                .font(Font.body.bold())
                .cornerRadius(25)

                Button(action: onNoButtonTap) {
                    Text(noButtonTitle)
                }
                .padding(.horizontal, 35)
                .padding(.vertical)
                .foregroundColor(.white)
                .background(Color.blue)
                .font(Font.body)
                .cornerRadius(25)
            }
        })
    }
}

//struct LoginYoNButtonsContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginYoNButtonsContainer()
//    }
//}
