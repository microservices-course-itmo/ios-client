//
//  RadioButton.swift
//  WineUp
//
//  Created by Александр Пахомов on 08.10.2020.
//

import SwiftUI

// MARK: - Model Protocol

protocol RadioButtonItem: Identifiable, Equatable {
    var textRepresentation: LocalizedStringKey { get }
}

// MARK: - View

/// View with optionally scrollable vertical stack of items to check
struct RadioButton<Item: RadioButtonItem>: View {

    /// Vertical spacing between items
    let spacing: CGFloat
    /// Abstract item which must know it's text representation
    let items: [Item]
    /// Max count of items checked. When trying to overflow the limit the first checked item becomes unchecked
    let maxChecked: Int?
    /// Optionally wrapps content in vertical ScrollView
    let isScrollable: Bool
    /// HIdes the line at the very bottom
    let isLineHidden: Bool
    /// Checked item image
    let checkedImage: Image
    /// Unchecked item image
    let normalImage: Image

    @Binding var checkedItems: [Item]

    init(spacing: CGFloat,
         items: [Item],
         maxChecked: Int? = nil,
         isScrollable: Bool = false,
         isLineHidden: Bool = true,
         checkedImage: Image = .checkedCheckbox,
         normalImage: Image = .normalCheckbox,
         checkedItems: Binding<[Item]>) {
        self.spacing = spacing
        self.items = items
        self.maxChecked = maxChecked
        self.isScrollable = isScrollable
        self.isLineHidden = isLineHidden
        self.checkedImage = checkedImage
        self.normalImage = normalImage
        self._checkedItems = checkedItems
    }

    var body: some View {
        if isScrollable {
            ScrollView(.vertical, showsIndicators: false, content: itemsList)
        } else {
            itemsList()
        }
    }

    // MARK: Displaying Items

    private func itemsList() -> some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(items) { item in
                ItemButton(
                    onTap: { itemButtonDidTap(item) },
                    item: item,
                    isLineHidden: isLineHidden || item == items.last,
                    checkedImage: checkedImage,
                    normalImage: normalImage,
                    checkedItems: $checkedItems
                )
            }
        }
    }

    // MARK: Helpers

    private func itemButtonDidTap(_ item: Item) {
        if checkedItems.contains(item) {
            checkedItems.remove(item)
        } else {
            if !canCheckItem {
                checkedItems.removeFirst()
            }
            if canCheckItem {
                checkedItems.append(item)
            }
        }
    }

    private var canCheckItem: Bool {
        guard let maxChecked = maxChecked else {
            return true
        }
        return checkedItems.count < maxChecked
    }
}

// MARK: - Preview

#if DEBUG
struct RadioButton_Previews: PreviewProvider {
    static let items = StubRadioButtonItem.mockedData

    @State private static var checkedZeroItems: [StubRadioButtonItem] = []
    @State private static var checkedOneItem = [items[0]]
    @State private static var checkedItems = [items[0], items[1]]

    static var previews: some View {
        Group {
            RadioButton(spacing: 8, items: items, maxChecked: 1, checkedItems: $checkedZeroItems)
            RadioButton(spacing: 8, items: items, isScrollable: true, checkedItems: $checkedOneItem)
            RadioButton(spacing: 8, items: items, isLineHidden: false, checkedItems: $checkedItems)
        }
        .previewLayout(.fixed(width: 420, height: 130))
    }
}
#endif
