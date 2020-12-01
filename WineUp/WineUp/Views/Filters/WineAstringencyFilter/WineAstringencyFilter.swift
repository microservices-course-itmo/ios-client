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

extension WineSugarFilter.Item: RadioButtonItem {
    var id: WineSugar {
        wineSugar
    }

    var textRepresentation: LocalizedStringKey {
        .init(wineSugar.name)
    }
}

// MARK: - Preview

#if DEBUG
struct WineSugarFilter_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WineSugarFilter(viewModel: .init())
        }
        .previewLayout(.fixed(width: 400, height: 250))
    }
}
#endif
