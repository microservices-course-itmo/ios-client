//
//  CatalogFiltersBarView+ItemView.swift
//  WineUp
//
//  Created by Александр Пахомов on 27.09.2020.
//

import SwiftUI

// MARK: - View

extension CatalogFiltersBarView {
    /// Filter visual representation without interaction
    struct ItemView: View {
        let item: Item

        var body: some View {
            Text(item.title)
                .foregroundColor(.primary)
                .font(.system(size: 13))
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
