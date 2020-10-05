//
//  CatalogFiltersBarItemButton.swift
//  WineUp
//
//  Created by Александр Пахомов on 27.09.2020.
//

import SwiftUI

// MARK: - View

struct CatalogFiltersBarItemButton: View {

    let item: CatalogFiltersBarItemModel
    let onTap: (() -> Void)?

    var body: some View {
        Button(action: didTap, label: {
            CatalogFiltersBarItemView(item: item).padding()
        })
    }
}

// MARK: - Helpers

private extension CatalogFiltersBarItemButton {
    func didTap() {
        onTap?()
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogFiltersBarItemButton_Previews: PreviewProvider {
    static var previews: some View {
        CatalogFiltersBarItemButton(item: CatalogFiltersBarItemModel.mockedData[0], onTap: nil)
    }
}
#endif
