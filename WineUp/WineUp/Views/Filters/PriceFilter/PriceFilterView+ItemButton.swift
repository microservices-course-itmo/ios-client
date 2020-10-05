//
//  PriceFilterView+ItemButton.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

// MARK: - View

extension PriceFilterView {
    /// `PriceFilterItemView` wrapper with `action` (onTap)  callback
    struct ItemButton: View {

        let item: Item
        let action: () -> Void

        var body: some View {
            Button(action: action) {
                ItemView(item: item)
                    .padding()
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct PriceFilterViewItemButtonPreview: PreviewProvider {
    private static let item = PriceFilterView.Item(title: "Test value")

    static var previews: some View {
        return PriceFilterView.ItemButton(item: item, action: {})
            .previewLayout(.fixed(width: 414, height: 250))
    }
}
#endif
