//
//  WineSugarFilter.swift
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

struct WineSugarFilter: View {

    let allCases: [WineSugar] = [.dry, .semiDry, .semiSweet, .sweet]
    @Binding var selected: [WineSugar]

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

// MARK: - WineSugar+RadioButtonItem

extension WineSugar: RadioButtonItem {
    var id: WineSugar {
        self
    }

    var textRepresentation: LocalizedStringKey {
        .init(name)
    }
}

// MARK: - Preview

#if DEBUG
struct WineSugarFilter_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WineSugarFilter(selected: .constant([.dry]))
        }
        .previewLayout(.fixed(width: 400, height: 250))
    }
}
#endif
