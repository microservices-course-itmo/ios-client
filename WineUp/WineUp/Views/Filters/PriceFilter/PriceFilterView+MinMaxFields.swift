//
//  PriceFilterView+MinMaxFields.swift
//  WineUp
//
//  Created by Александр Пахомов on 05.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let fieldsHSpacing: CGFloat = 15
    static let fieldsVSpacing: CGFloat = 10
}

private extension Color {
    static let fieldTitle: Color = .gray
}

private extension LocalizedStringKey {
    static let fieldFromTitle = LocalizedStringKey("От")
    static let fieldToTitle = LocalizedStringKey("До")
    static let fieldFromPlaceholder = LocalizedStringKey("0000")
    static let fieldToPlaceholder = LocalizedStringKey("0000")
}

// MARK: - View

extension PriceFilterView {
    /// View with fields for manual price interval setting
    struct MinMaxFields: View {

        @Binding var fromPrice: String
        @Binding var toPrice: String

        var body: some View {
            HStack(alignment: .center, spacing: .fieldsHSpacing) {
                VStack(alignment: .leading, spacing: .fieldsVSpacing) {
                    Text(LocalizedStringKey.fieldFromTitle)
                        .foregroundColor(.fieldTitle)

                    TextField(LocalizedStringKey.fieldFromPlaceholder, text: $fromPrice)

                    Divider()
                }

                VStack(alignment: .leading, spacing: .fieldsVSpacing) {
                    Text(LocalizedStringKey.fieldToTitle)
                        .foregroundColor(.fieldTitle)

                    TextField(LocalizedStringKey.fieldToPlaceholder, text: $toPrice)

                    Divider()
                }
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct PriceFilterViewMinMaxFields_Previews: PreviewProvider {

    @State private static var fromPrice: String = ""
    @State private static var toPrice: String = ""

    static var previews: some View {
        return PriceFilterView.MinMaxFields(fromPrice: $fromPrice, toPrice: $toPrice)
            .previewLayout(.fixed(width: 390, height: 80))
    }
}
#endif
