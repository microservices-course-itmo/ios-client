//
//  CatalogRowView+PreviewImageView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - View

extension CatalogRowView {
    /// Catalog item title image and rating overlay view
    struct PreviewImageView: View {

        let item: CatalogView.Item

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
                    RatingView(item: item)
                        .frame(
                            width: 110,
                            height: 50,
                            alignment: .bottom
                        )
                }
            }
        }
    }

}

// MARK: - Preview

#if DEBUG
struct CatalogRowViewPreviewImageView_Previews: PreviewProvider {
    static var previews: some View {
        return CatalogRowView.PreviewImageView(item: CatalogView.Item.mockedData[0])
            .previewLayout(.fixed(width: 130, height: 130))
    }
}
#endif
