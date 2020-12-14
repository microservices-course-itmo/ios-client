//
//  SubmitDialog.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension Font {
    static let filterTitle: Font = .title
}

// MARK: - View

/// Container with just Title, Label and 'Submit' button in vertical stack
struct SubmitDialog<Label: View>: View {

    let title: String
    let onSubmit: () -> Void
    let label: () -> Label

    var body: some View {
        VStack {
            Text(title)
                .font(.filterTitle)
                .padding([.leading, .top])
                .horizontallySpanned(alignment: .leading)

            label()

            Button(action: onSubmit, label: {
                Text("Применить")
                    .horizontallySpanned()
            })
            .defaultStyled(isDisabled: false)
        }
        .padding(8)
        .background(
            Color.white
                .cornerRadius(16)
                .faintShadow()
        )
        .padding(8)
    }
}

// MARK: - Preview

#if DEBUG
struct FilterContainer_Previews: PreviewProvider {
    static var previews: some View {
        SubmitDialog(title: "Title", onSubmit: {}, label: {
            Color.red
                .frame(width: 100, height: 100)
                .padding()
        })
    }
}
#endif
