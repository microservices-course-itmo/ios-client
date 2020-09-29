//
//  CatalogFiltersBarItemButton.swift
//  WineUp
//
//  Created by Александр Пахомов on 27.09.2020.
//

import SwiftUI

struct CatalogFiltersBarItemButton: View {
    let item: CatalogFiltersBarItemModel
    let action: () -> Void

    var body: some View {
        Button(action: action, label: {
            CatalogFiltersBarItemView(item: item).padding()
        })
    }
}
