//
//  CatalogFiltersBarView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

struct CatalogFiltersBarView: View {

    // MARK: - State

    var items: [CatalogFiltersBarItemModel]
    var onItemTap: OnItemTap?

    // MARK: - View

    var body: some View {
        VStack(spacing: 0.0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10.0) {
                    ForEach(items) { item in
                        CatalogFiltersBarItemButton(item: item, action: { self.itemDidTap(item) })
                            .frame(minWidth: 60, maxWidth: .infinity)
                    }
                }
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
            Divider()
        }

    }

    // MARK: - Actions

    typealias OnItemTap = (CatalogFiltersBarItemModel) -> Void

    private func itemDidTap(_ item: CatalogFiltersBarItemModel) {
        onItemTap?(item)
    }
}

#if DEBUG
struct CatalogFilterViewPreviews: PreviewProvider {
    private static let items = [
        CatalogFiltersBarItemModel(title: "Рекомендованные"),
        CatalogFiltersBarItemModel(title: "Цена"),
        CatalogFiltersBarItemModel(title: "Страна"),
        CatalogFiltersBarItemModel(title: "Цвет"),
        CatalogFiltersBarItemModel(title: "Сахар")
    ]

    static var previews: some View {
        VStack() {
            CatalogFiltersBarView(items: items, onItemTap: nil)
        }
        .previewLayout(.fixed(width: 414, height: 120))
        .background(Color.red)
    }
}
#endif
