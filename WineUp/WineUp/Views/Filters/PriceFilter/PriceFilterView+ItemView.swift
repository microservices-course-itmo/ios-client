//
//  PriceFilterView+ItemView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension Font {
    static let itemTitle: Font = .system(size: 13)
}

private extension Color {
    static let itemTitle: Color = .primary
    static let border = Color(.systemGray4)
}

private extension CGFloat {
    static let borderWidth: CGFloat = 1
    static let borderCornerRadius: CGFloat = 25
    static let borderHPadding: CGFloat = -10
    static let borderVPadding: CGFloat = -10
}

// MARK: - View

extension PriceFilterView {
    /// Predefined price interval non-interactive view
    struct ItemView: View {

        let item: Item

        var body: some View {
            Text(item.title)
                .foregroundColor(.itemTitle)
                .font(.itemTitle)
                .overlay(
                    RoundedRectangle(cornerRadius: .borderCornerRadius)
                        .stroke(Color.border, lineWidth: .borderWidth)
                        .padding([.leading, .trailing], .borderHPadding)
                        .padding([.top, .bottom], .borderVPadding)
                )
        }
    }
}

// MARK: - Preview

#if DEBUG
struct PriceFilterViewItemView_Previews: PreviewProvider {
    private static let item = PriceFilterView.Item.mockedData[0]

    static var previews: some View {
        return PriceFilterView.ItemView(item: item)
            .previewLayout(.fixed(width: 414, height: 250))
    }
}
#endif
