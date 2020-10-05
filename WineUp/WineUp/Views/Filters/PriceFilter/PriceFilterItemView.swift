//
//
//  PriceFilterItems.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

// MARK: - View

/// Predefined price interval non-interactive view
struct PriceFilterItemView: View {

    let item: PriceFilterView.Item

    var body: some View {
        Text(item.title)
            .foregroundColor(.primary)
            .font(.system(size: 13))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color(.systemGray4), lineWidth: 1)
                    .padding([.leading, .trailing], -10)
                    .padding([.top, .bottom], -10)
            )
    }
}

// MARK: - Preview

#if DEBUG
struct PriceFilterItemViewPreview: PreviewProvider {
    private static let item = PriceFilterView.Item(title: "Test value")

    static var previews: some View {
        return PriceFilterItemView(item: item)
            .previewLayout(.fixed(width: 414, height: 250))
    }
}
#endif
