//
//  PriceFilter.swift
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
struct PriceFilter: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: .rootVSpacing) {

            MinMaxFields(minPriceRub: $viewModel.minPriceRub, maxPriceRub: $viewModel.maxPriceRub)

            // Discount offers switch
            Toggle(isOn: $viewModel.showDiscountOffers) {
                Text(LocalizedStringKey.discountOffersSwitchTitle)
            }

            // Scrollable list of predefined prices intervals
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: .predefinedListItemsHSpacing) {
                    ForEach(viewModel.predefinedPrices) { interval in
                        PredefinedPriceIntervalButton(
                            interval: interval,
                            action: {
                                viewModel.predefinedPriceIntervalDidTap(interval)
                            }
                        )
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
struct PriceFilter_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PriceFilter(viewModel: .init())
        }
        .previewLayout(.fixed(width: 414, height: 250))
    }
}
#endif
