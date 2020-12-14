//
//  LoginContainer.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let actionLabelTop: CGFloat = 75
    static let viewLabelTop: CGFloat = 50
}

private extension Font {
    static let containerTitle: Font = .title
}

// MARK: - View

/// Login container with vertically located View and Action labels
struct LoginContainer<ViewLabel: View, ActionLabel: View>: View {

    let title: String
    let viewLabel: () -> ViewLabel
    let actionLabel: () -> ActionLabel

    var body: some View {
        VStack(alignment: .center, spacing: .actionLabelTop) {
            VStack(alignment: .center, spacing: .viewLabelTop) {
                Text(title)
                    .font(.containerTitle)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)

                viewLabel()
                    .frame(minHeight: UIScreen.main.bounds.height * 0.075)
            }

            actionLabel()
        }
    }
}

// MARK: - Preview

#if DEBUG
struct LoginContainer_Previews: PreviewProvider {
    static var previews: some View {
        LoginContainer(title: "Title", viewLabel: {
            Text("ViewLabel")
        }, actionLabel: {
            Text("ActionLabel")
        })
    }
}
#endif
