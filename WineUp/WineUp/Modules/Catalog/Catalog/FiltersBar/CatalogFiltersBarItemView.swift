//
//  CatalogFiltersBarItemView.swift
//  WineUp
//
//  Created by Александр Пахомов on 27.09.2020.
//

import SwiftUI

struct CatalogFiltersBarItemView: View {

    // MARK: - State

    let item: CatalogFiltersBarItemModel

    // MARK: - View

    var body: some View {
        Text(item.title)
            .foregroundColor(.primary)
            .font(.system(size: 13))
    }
}
