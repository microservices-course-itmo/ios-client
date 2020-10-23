//
//  FilterContainer.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension Font {
    static let filterTitle: Font = .title
    static let buttonTitle: Font = .body
}

private extension Color {
    static let buttonTitle: Color = .white
    static let buttonBackground: Color = .blue
}

// MARK: - View

struct FilterContainer<Filter: View>: View {

    let title: String
    let onSubmit: () -> Void
    let filter: () -> Filter

    var body: some View {
        VStack {
            Text(title)
                .font(.filterTitle)
                .padding()

            filter()

            Button(action: onSubmit, label: {
                Text("Применить")
                    .font(.buttonTitle)
                    .foregroundColor(.buttonTitle)
                    .padding()
                    .padding(.horizontal, 16)
                    .background(Color.buttonBackground.cornerRadius(16))
            })
            .padding(.bottom)
        }
        .padding(8)
        .background(
            Color.white
                .cornerRadius(25)
                .faintShadow()
        )
        .padding(8)
    }
}

// MARK: - Preview

#if DEBUG
struct FilterContainer_Previews: PreviewProvider {
    static var previews: some View {
        FilterContainer(title: "Title", onSubmit: {}, filter: {
            Color.red
                .frame(width: 100, height: 100)
                .padding()
        })
    }
}
#endif
