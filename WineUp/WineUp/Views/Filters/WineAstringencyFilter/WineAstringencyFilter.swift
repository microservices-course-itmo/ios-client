//
//  WineAstringencyFilter.swift
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

struct WineAstringencyFilter: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        RadioButton(
            spacing: 0,
            items: viewModel.items,
            maxChecked: nil,
            isScrollable: false,
            isLineHidden: false,
            checkedItems: $viewModel.checkedItems
        )
        .font(.radioButton)
    }
}

// MARK: - RadioButtonItem

extension WineAstringencyFilter.Item: RadioButtonItem {
    var id: WineAstringency {
        wineAstringency
    }

    var textRepresentation: LocalizedStringKey {
        .init(wineAstringency.name)
    }
}

// MARK: - Preview

#if DEBUG
struct WineAstringencyFilter_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WineAstringencyFilter(viewModel: .init())
        }
        .previewLayout(.fixed(width: 400, height: 250))
    }
}
#endif
