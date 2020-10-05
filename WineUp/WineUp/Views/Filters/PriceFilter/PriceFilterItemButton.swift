//
//  PriceFilterItemButton.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

// MARK: - View

struct PriceFilterItemButton: View {

    let item: PriceFilterView.Item
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            PriceFilterItemView(item: item)
                .padding()
        }
    }
}

// MARK: - Preview

#if DEBUG
struct PriceFilterItemButtonPreview: PreviewProvider {
    private static let item = PriceFilterView.Item(title: "Test value")

    static var previews: some View {
        return PriceFilterItemButton(item: item, action: {})
            .previewLayout(.fixed(width: 414, height: 250))
    }
}
#endif
