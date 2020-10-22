//
//  LoginContainer.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI

struct LoginContainer<ViewLabel: View, ActionLabel: View>: View {

    let title: String
    let viewLabel: () -> ViewLabel
    let actionLabel: () -> ActionLabel

    var body: some View {
        VStack(alignment: .center, spacing: 75) {
            VStack(alignment: .center, spacing: 50) {
                Text(title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)

                viewLabel()
            }

            actionLabel()
        }
    }
}
//
//struct LoginContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginContainer()
//    }
//}
