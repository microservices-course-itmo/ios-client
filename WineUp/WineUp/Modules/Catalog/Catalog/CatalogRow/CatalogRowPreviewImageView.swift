//
//  CatalogRowPreviewImageView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - View

struct CatalogRowPreviewImageView: View {

    let item: CatalogItemModel

    var body: some View {
        ZStack {
            Image(uiImage: item.titleImage)
                .resizable()
                .frame(
                    width: 110,
                    height: 130,
                    alignment: .center
                )
                .aspectRatio(contentMode: .fit)
            VStack {
                Spacer()
                CatalogRowRatingView(item: item)
                    .frame(
                        width: 110,
                        height: 50,
                        alignment: .bottom
                    )
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRowPreviewImageView_Previews: PreviewProvider {
    static var previews: some View {
        return CatalogRowPreviewImageView(item: CatalogItemModel.mockedData[0])
            .previewLayout(.fixed(width: 130, height: 130))
    }
}
#endif
