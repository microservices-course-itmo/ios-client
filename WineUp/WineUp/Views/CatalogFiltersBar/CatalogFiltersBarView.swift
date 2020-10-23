//
//  CatalogFiltersBarView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let barHeight: CGFloat = 60
    static let interitemSpacing: CGFloat = 10
    static let minItemWidth: CGFloat = 60
}

// MARK: - View

/// Horizontal scrollable list of filters with callback on tap on a filter
struct CatalogFiltersBarView: View {

    let items: [Item]
    let onItemTap: ((Item) -> Void)?

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false, content: itemsHStack)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: .barHeight,
                    maxHeight: .barHeight,
                    alignment: .center
                )
            Divider()
        }
    }
}

// MARK: - Model

extension CatalogFiltersBarView {
    enum Item: Identifiable, Hashable {
        case recomendation, price, wineAstringency, wineColor, country

        var id: Int {
            hashValue
        }
    }
}

// MARK: - Displaying Items

private extension CatalogFiltersBarView {
    func itemsHStack() -> some View {
        HStack(spacing: .interitemSpacing) {
            ForEach(items) { item in
                ItemButton(item: item, onTap: { itemDidTap(item) })
                    .frame(minWidth: .minItemWidth, maxWidth: .infinity)
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
struct CatalogFiltersBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CatalogFiltersBarView(items: CatalogFiltersBarView.Item.mockedData, onItemTap: nil)
        }
        .previewLayout(.fixed(width: 414, height: 120))
        .background(Color.red)
    }
}
#endif
