//
//  CatalogFiltersBarView+ItemView.swift
//  WineUp
//
//  Created by Александр Пахомов on 27.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension Font {
    static let itemTitle: Font = .system(size: 13)
}

private extension Color {
    static let itemTitle: Color = .primary
}

// MARK: - View

extension CatalogFiltersBarView {
    /// Filter visual representation without interaction
    struct ItemView: View {
        let item: Item

        var body: some View {
            Text(title)
                .foregroundColor(.itemTitle)
                .font(.itemTitle)
        }

        // MARK: Helpers

        private var title: String {
            switch item {
            case .recomendation:
                return "Рекомендованные"
            case .price:
                return "Цена"
            case .country:
                return "Страна"
            case .wineColor:
                return "Цвет"
            case .wineAstringency:
                return "Сахар"
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogFiltersBarViewItemView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogFiltersBarView.ItemView(item: CatalogFiltersBarView.Item.mockedData[0])
            .previewLayout(.fixed(width: 80, height: 60))
    }
}
#endif
