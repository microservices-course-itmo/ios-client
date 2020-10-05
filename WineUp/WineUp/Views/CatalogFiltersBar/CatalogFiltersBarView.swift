//
//  CatalogFiltersBarView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

// MARK: - View

/// Horizontal scrollable list of filters with callback on tap on a filter
struct CatalogFiltersBarView: View {

    let items: [Item]
    let onItemTap: ((Item) -> Void)?

    var body: some View {
        VStack(spacing: 0.0) {
            ScrollView(.horizontal, showsIndicators: false, content: itemsHStack)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 60,
                    maxHeight: 60,
                    alignment: .center
                )
            Divider()
        }
    }
}

// MARK: - Displaying Items

private extension CatalogFiltersBarView {
    func itemsHStack() -> some View {
        HStack(spacing: 10.0) {
            ForEach(items) { item in
                CatalogFiltersBarItemButton(item: item, onTap: { self.itemDidTap(item) })
                    .frame(minWidth: 60, maxWidth: .infinity)
            }
        }
    }
}

// MARK: - Helpers

private extension CatalogFiltersBarView {
    func itemDidTap(_ item: Item) {
        onItemTap?(item)
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogFilterView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CatalogFiltersBarView(items: CatalogFiltersBarView.Item.mockedData, onItemTap: nil)
        }
        .previewLayout(.fixed(width: 414, height: 120))
        .background(Color.red)
    }
}
#endif
