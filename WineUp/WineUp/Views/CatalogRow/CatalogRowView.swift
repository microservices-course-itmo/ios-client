//
//  CatalogRowView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let previewWidth: CGFloat = 110
    static let previewHeight: CGFloat = 330
}

// MARK: - View

/// Catalog item visual representation (like `UITableViewCell`)
struct CatalogRowView: View {
    
    let item: CatalogView.RowItem

    var body: some View {
        HStack {
            PreviewImageView(item: item)
                .frame(
                    width: .previewWidth,
                    height: .previewHeight,
                    alignment: .center
                )
            InfoView(item: item)
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRowView_Previews: PreviewProvider {
    static var previews: some View {
        let item = CatalogView.RowItem.mockedData[1]
        return CatalogRowView(item: item)
            .previewLayout(.fixed(width: 414, height: 350))
    }
}
#endif
