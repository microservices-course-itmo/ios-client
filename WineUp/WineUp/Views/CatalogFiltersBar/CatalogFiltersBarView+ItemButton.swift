//
//  CatalogFiltersBarView+ItemButton.swift
//  WineUp
//
//  Created by Александр Пахомов on 27.09.2020.
//

import SwiftUI

// MARK: - View

extension CatalogFiltersBarView {
    /// `CatalogFiltersBarView.ItemView` wrapper with `onTap` callback
    struct ItemButton: View {

        let item: Item
        let onTap: (() -> Void)?

        var body: some View {
            Button(action: didTap, label: {
                ItemView(item: item).padding()
            })
        }

        // MARK: Helpers

        private func didTap() {
            onTap?()
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogFiltersBarViewItemButton_Previews: PreviewProvider {
    static var previews: some View {
        CatalogFiltersBarView.ItemButton(item: CatalogFiltersBarView.Item.mockedData[0], onTap: nil)
    }
}
#endif
