//
//  PriceFilterView+MinMaxFields.swift
//  WineUp
//
//  Created by Александр Пахомов on 05.10.2020.
//

import SwiftUI

// MARK: - View

extension PriceFilterView {
    /// View with fields for manual price interval setting
    struct MinMaxFields: View {

        @Binding var fromPrice: String
        @Binding var toPrice: String

        var body: some View {
            HStack(alignment: .center, spacing: 15) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("От").foregroundColor(.gray)
                    TextField("0000", text: $fromPrice)
                    Divider()
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("До").foregroundColor(.gray)
                    TextField("0000", text: $toPrice)
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
