//
//  SingleCheckedRadioButton.swift
//  WineUp
//
//  Created by Александр Пахомов on 08.10.2020.
//

import SwiftUI

// MARK: - View

/// Wrapper of RadioButton with mapping `checkedItems` array to a single optional `checkedItem` value
struct SingleCheckedRadioButton<Item: RadioButtonItem>: View {

    /// Vertical spacing between items
    let spacing: CGFloat
    /// Abstract item which must know it's text representation
    let items: [Item]
    /// Optionally wrapps content in vertical ScrollView
    let isScrollable: Bool
    /// HIdes the line at the very bottom
    let isLineHidden: Bool
    /// Checked item image
    let checkedImage: Image
    /// Unchecked item image
    let normalImage: Image

    @Binding var checkedItem: Item?

    init(
        spacing: CGFloat,
        items: [Item],
        isScrollable: Bool = false,
        isLineHidden: Bool = true,
        checkedImage: Image = .largecircleFillCircle,
        normalImage: Image = .circle,
        checkedItem: Binding<Item?>) {
        self.spacing = spacing
        self.items = items
        self.isScrollable = isScrollable
        self.isLineHidden = isLineHidden
        self.checkedImage = checkedImage
        self.normalImage = normalImage
        self._checkedItem = checkedItem
    }

    var body: some View {
        RadioButton<Item>(
            spacing: spacing,
            items: items,
            maxChecked: 1,
            isScrollable: isScrollable,
            isLineHidden: isLineHidden,
            checkedImage: checkedImage,
            normalImage: normalImage,
            checkedItems: checkedItems
        )
    }

    // MARK: Helpers

    /// Computed array mapped from `checkedItem`
    private var checkedItems: Binding<[Item]> {
        Binding<[Item]>(get: {
            checkedItem.flatMap { [$0] } ?? []
        }, set: {
            checkedItem = $0.first
        })
    }
}

// MARK: - Preview

#if DEBUG
struct SingleCheckedRadioButton_Previews: PreviewProvider {
    static let items = StubRadioButtonItem.mockedData

    @State private static var firstCheckedItem: StubRadioButtonItem? = items[0]
    @State private static var secondCheckedItem: StubRadioButtonItem? = items[1]
    @State private static var nilCheckedItem: StubRadioButtonItem?

    static var previews: some View {
        Group {
            SingleCheckedRadioButton(spacing: 8, items: items, checkedItem: $firstCheckedItem)
            SingleCheckedRadioButton(spacing: 8, items: items, checkedItem: $secondCheckedItem)
            SingleCheckedRadioButton(spacing: 8, items: items, checkedItem: $nilCheckedItem)
        }
        .previewLayout(.fixed(width: 420, height: 130))
    }
}
#endif
