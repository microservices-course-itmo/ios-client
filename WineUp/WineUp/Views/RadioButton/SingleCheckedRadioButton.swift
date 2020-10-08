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

    @Binding var checkedItem: Item?

    var body: some View {
        RadioButton<Item>(
            spacing: spacing,
            items: items,
            maxChecked: 1,
            isScrollable: isScrollable,
            checkedItems: checkedItems
        )
    }
}

// MARK: - Helpers

private extension SingleCheckedRadioButton {
    /// Computed array mapped from `checkedItem`
    var checkedItems: Binding<[Item]> {
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
            SingleCheckedRadioButton(spacing: 0, items: items, isScrollable: false, checkedItem: $firstCheckedItem)
            SingleCheckedRadioButton(spacing: 16, items: items, isScrollable: false, checkedItem: $secondCheckedItem)
            SingleCheckedRadioButton(spacing: 16, items: items, isScrollable: false, checkedItem: $nilCheckedItem)
        }
        .previewLayout(.fixed(width: 420, height: 130))
    }
}
#endif
