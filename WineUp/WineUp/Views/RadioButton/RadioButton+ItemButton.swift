//
//  RadioButton+ItemButton.swift
//  WineUp
//
//  Created by Александр Пахомов on 08.10.2020.
//

import SwiftUI

// MARK: - View

extension RadioButton {
    /// Interactive representation of Item, wrapper of ItemView
    struct ItemButton<Item: RadioButtonItem>: View {

        /// On button tap callback
        let onTap: () -> Void
        /// Item for the button
        let item: Item

        @Binding var checkedItems: [Item]

        var body: some View {
            Button(action: onTap) {
                RadioButton.ItemView(item: item, checkedItems: $checkedItems)
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct RadioButtonItemButton_Previews: PreviewProvider {
    static let items = StubRadioButtonItem.mockedData

    @State private static var checkedZeroItems: [StubRadioButtonItem] = []
    @State private static var checkedOneItem = [items[0]]
    @State private static var checkedItems = [items[0], items[1]]

    static var previews: some View {
        Group {
            RadioButton<StubRadioButtonItem>.ItemButton(onTap: {}, item: items[0], checkedItems: $checkedZeroItems)
            RadioButton<StubRadioButtonItem>.ItemButton(onTap: {}, item: items[0], checkedItems: $checkedOneItem)
            RadioButton<StubRadioButtonItem>.ItemButton(onTap: {}, item: items[0], checkedItems: $checkedItems)
        }
        .previewLayout(.fixed(width: 420, height: 60))
    }
}
#endif
