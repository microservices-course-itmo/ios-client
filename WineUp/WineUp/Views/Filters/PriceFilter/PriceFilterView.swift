//
//  PriceFilterView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let rootVSpacing: CGFloat = 10
    static let predefinedListItemsHSpacing: CGFloat = 0
    static let predefinedItemMinWidth: CGFloat = 60
    static let predefinedListHeight: CGFloat = 60
}

private extension LocalizedStringKey {
    static let discountOffersSwitchTitle = LocalizedStringKey("Товар со скидкой")
}

// MARK: - View

/// Price filter view
struct PriceFilterView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: .rootVSpacing) {

            MinMaxFields(fromPrice: $viewModel.minPriceString, toPrice: $viewModel.maxPriceString)

            // Discount offers switch
            Toggle(isOn: $viewModel.showDiscountOffers) {
                Text(LocalizedStringKey.discountOffersSwitchTitle)
            }

            // Scrollable list of predefined prices intervals
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: .predefinedListItemsHSpacing) {
                    ForEach(viewModel.predefinedPrices) { item in
                        ItemButton(item: item, action: { viewModel.itemDidTap(item) })
                            .frame(minWidth: .predefinedItemMinWidth, maxWidth: .infinity)
                    }
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: .predefinedListHeight,
                maxHeight: .predefinedListHeight,
                alignment: .center
            )
        }
        .padding()
    }
}

// MARK: - Preview

#if DEBUG
struct PriceFilterView_Previews: PreviewProvider {
    static var previews: some View {
        return PriceFilterView(viewModel: .init())
            .previewLayout(.fixed(width: 414, height: 250))
    }
}
#endif
