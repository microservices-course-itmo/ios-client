//
//  PriceFilterItemButton.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

struct PriceFilterItemButton: View {
    let item: PriceFilterItemModel
    let action: () -> Void

    var body: some View {
        Button(action: action, label: {
            PriceFilterItemView(item: item).padding()
        })
    }
}

#if DEBUG
struct PriceFilterItemButtonPreview: PreviewProvider {
    private static let item = PriceFilterItemModel(title: "Test value")
    static var previews: some View {
        return PriceFilterItemButton(item: item, action: {})
            .previewLayout(.fixed(width: 414, height: 250))
    }
}
#endif
