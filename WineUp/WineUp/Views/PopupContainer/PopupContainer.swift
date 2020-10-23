//
//  PopupContainer.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.10.2020.
//

import SwiftUI

// MARK: - View

struct PopupContainer<Label: View>: View {

    let onShouldDismiss: () -> Void
    let label: () -> Label

    var body: some View {
        ZStack {
            Color(white: 0, opacity: 0.25)
                .onTapGesture(perform: onShouldDismiss)

            VStack {
                Spacer()
                label()
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct PopupContainer_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white

            PopupContainer(onShouldDismiss: {}, label: {
                Color.red
                    .frame(width: 100, height: 100)
                    .padding()
            })
        }
    }
}
#endif
