//
//  WineColorFilter.swift
//  WineUp
//
//  Created by Александр Пахомов on 09.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension Font {
    static let radioButton: Font = .system(size: 13)
}

// MARK: - View

struct WineColorFilter: View {

    let allCases: [WineColor] = [.red, .orange, .white, .rose]
    @Binding var selected: [WineColor]

    var body: some View {
        RadioButton(
            spacing: 0,
            items: allCases,
            maxChecked: nil,
            isScrollable: false,
            isLineHidden: false,
            checkedItems: $selected
        )
        .font(.radioButton)
    }
}

// MARK: - WineColor+RadioButtonItem

extension WineColor: RadioButtonItem {
    var id: WineColor {
        self
    }

    var textRepresentation: LocalizedStringKey {
        .init(name)
    }
}

// MARK: - Preview

#if DEBUG
struct WineColorFilter_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WineColorFilter(selected: .constant([]))
        }
        .previewLayout(.fixed(width: 400, height: 250))
    }
}
#endif
