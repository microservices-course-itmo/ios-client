//
//  PriceFilter+ItemButton.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

// MARK: - View

extension PriceFilter {
    /// `PriceFilterItemView` wrapper with `action` (onTap)  callback
    struct PredefinedPriceIntervalButton: View {

        let interval: PredefinedPriceInterval
        @Binding var selectedInterval: PredefinedPriceInterval?
        let action: () -> Void

        var isSelected: Bool {
            guard let selected = selectedInterval else { return false }
            return selected == interval
        }

        var body: some View {
            Button(action: action) {
                PredefinedPriceIntervalView(isSelected: isSelected, interval: interval)
                    .padding()
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct PriceFilterItemButtonPreview: PreviewProvider {
    private static let interval = PriceFilter.PredefinedPriceInterval.mockedData[0]

    static var previews: some View {
        Group {
            PriceFilter.PredefinedPriceIntervalButton(interval: interval,
                                                      selectedInterval: .constant(.lessThan(maxPriceRub: 222)),
                                                      action: {})
        }
        .previewLayout(.fixed(width: 414, height: 250))
    }
}
#endif
