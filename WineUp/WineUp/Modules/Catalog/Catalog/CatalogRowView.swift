//
//  CatalogRowView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

struct CatalogRowView: View {
    private let item: CatalogItemModel

    var body: some View {
        Text(item.description)
    }

    init(item: CatalogItemModel) {
        self.item = item
    }
}

#if DEBUG
struct CatalogRowViewPreviews: PreviewProvider {
    static var previews: some View {
        let item = CatalogItemModel(title: "ASD")
        return CatalogRowView(item: item)
            .previewLayout(.fixed(width: 414, height: 140))
    }
}
#endif
