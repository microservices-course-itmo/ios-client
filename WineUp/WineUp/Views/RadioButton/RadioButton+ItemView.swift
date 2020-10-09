//
//  RadioButton+ItemView.swift
//  WineUp
//
//  Created by Александр Пахомов on 08.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let checkboxSize: CGFloat = 15.0
}

private extension Color {
    static let checkedCheckbox = Color(hex: 0x006400)
    static let normalCheckbox = Color.black
    static let itemText = Color(.label)
}

private extension Image {
    static let checkedCheckbox = Image(systemName: "checkmark.square")
    static let normalCheckbox = Image(systemName: "square")
}

// MARK: - View

extension RadioButton {
    /// Non-interactive representation of Item
    struct ItemView<Item: RadioButtonItem>: View {

        /// Item for the view
        let item: Item
        /// HIdes the line at the very bottom
        let isLineHidden: Bool

        @Binding var checkedItems: [Item]

        var body: some View {
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 8) {
                    checkboxImage
                        .resizable()
                        .frame(width: .checkboxSize, height: .checkboxSize)
                        .foregroundColor(checkboxColor)

                    Text(text)
                        .foregroundColor(.itemText)

                    Spacer()
                }
                .padding([.leading, .top, .bottom])

                if !isLineHidden {
                    Divider()
                }
            }
        }
    }
}

// MARK: - Helpers

private extension RadioButton.ItemView {
    var checkboxImage: Image {
        isChecked ? .checkedCheckbox : .normalCheckbox
    }

    var checkboxColor: Color {
        isChecked ? .checkedCheckbox : .normalCheckbox
    }

    var text: LocalizedStringKey {
        item.textRepresentation
    }

    var isChecked: Bool {
        checkedItems.contains(item)
    }
}

// MARK: - Preview

#if DEBUG
struct RadioButtonItemView_Previews: PreviewProvider {
    static let items = StubRadioButtonItem.mockedData

    @State private static var checkedZeroItems: [StubRadioButtonItem] = []
    @State private static var checkedOneItem = [items[0]]
    @State private static var checkedItems = [items[0], items[1]]

    static var previews: some View {
        Group {
            RadioButton<StubRadioButtonItem>.ItemView(item: items[0], isLineHidden: false, checkedItems: $checkedZeroItems)
            RadioButton<StubRadioButtonItem>.ItemView(item: items[1], isLineHidden: false, checkedItems: $checkedOneItem)
            RadioButton<StubRadioButtonItem>.ItemView(item: items[1], isLineHidden: true, checkedItems: $checkedItems)
        }
        .previewLayout(.fixed(width: 420, height: 60))
    }
}
#endif