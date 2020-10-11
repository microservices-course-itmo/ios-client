//
//  CatalogRowView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

struct CatalogRowView: View {

    // MARK: - Private Properties

    private let item: CatalogItemModel

    // MARK: - Lifecycle

    init(item: CatalogItemModel) {
        self.item = item
    }

    // MARK: - View

    var body: some View {
        ZStack {
            HStack {
                CatalogRowPreviewImageView(item: item)
                    .frame(
                        width: 110,
                        height: 130,
                        alignment: .center
                    )
                CatalogRowInfoView(item: item)
            }
        }
    }
}

#if DEBUG
struct CatalogRowViewPreviews: PreviewProvider {
    static var previews: some View {
        let item = CatalogItemModel(title: "Вино для хуесосов")
        return CatalogRowView(item: item)
            .previewLayout(.fixed(width: 414, height: 150))
    }
}
#endif