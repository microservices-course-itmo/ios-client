//
//  CatalogRowView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

// MARK: - View

/// Catalog item visual representation (like `UITableViewCell`)
struct CatalogRowView: View {

    let item: CatalogView.Item

    var body: some View {
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

// MARK: - Preview

#if DEBUG
struct CatalogRowView_Previews: PreviewProvider {
    static var previews: some View {
        let item = CatalogView.Item.mockedData[0]
        return CatalogRowView(item: item)
            .previewLayout(.fixed(width: 414, height: 150))
    }
}
#endif
