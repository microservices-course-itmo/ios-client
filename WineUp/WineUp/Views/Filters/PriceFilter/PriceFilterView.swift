//
//  PriceFilterView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

// MARK: - View

/// Price filter view
struct PriceFilterView: View {

    @State private var fromPrice: String = ""
    @State private var toPrice: String = ""
    @State private var toggleSwitch = false

    var items: [Item]
    var onItemTap: ((Item) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            MinMaxFields(fromPrice: $fromPrice, toPrice: $toPrice)

            // Discount offers switch
            Toggle(isOn: $toggleSwitch) {
                Text("Товар со скидкой")
            }

            // Scrollable list of predefined prices intervals
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0.0) {
                    ForEach(items) { item in
                        ItemButton(item: item, action: { self.itemDidTap(item) })
                            .frame(minWidth: 60, maxWidth: .infinity)
                    }
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 60,
                maxHeight: 60,
                alignment: .center
            )
        }
        .padding(.leading, 5)
        .padding(.trailing, 10)
    }
}

// MARK: - Helpers

private extension PriceFilterView {
    func itemDidTap(_ item: Item) {
        onItemTap?(item)
    }
}

// MARK: - Preview

#if DEBUG
struct PriceFilterView_Previews: PreviewProvider {
    static var previews: some View {
        return PriceFilterView(items: PriceFilterView.Item.mockedData, onItemTap: nil)
            .previewLayout(.fixed(width: 414, height: 250))
    }
}
#endif
