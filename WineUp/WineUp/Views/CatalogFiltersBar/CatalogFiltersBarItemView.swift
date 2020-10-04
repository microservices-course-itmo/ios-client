//
//  CatalogFiltersBarItemView.swift
//  WineUp
//
//  Created by Александр Пахомов on 27.09.2020.
//

import SwiftUI

// MARK: - View

struct CatalogFiltersBarItemView: View {

    let item: CatalogFiltersBarItemModel

    var body: some View {
        Text(item.title)
            .foregroundColor(.primary)
            .font(.system(size: 13))
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogFiltersBarItemViewPreviews: PreviewProvider {
    static var previews: some View {
        CatalogFiltersBarItemView(item: CatalogFiltersBarItemModel.mockedData[0])
            .previewLayout(.fixed(width: 80, height: 60))
    }
}
#endif
