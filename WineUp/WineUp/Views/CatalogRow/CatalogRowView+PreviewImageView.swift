//
//  CatalogRowView+PreviewImageView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let titleImageWidth: CGFloat = 110
    static let titleImageHeight: CGFloat = 130
    static let ratingViewWidth: CGFloat = 110
    static let ratingViewHeight: CGFloat = 50
}

// MARK: - View

extension CatalogRowView {
    /// Catalog item title image and rating overlay view
    struct PreviewImageView: View {

        let item: CatalogView.RowItem

        var body: some View {
            ZStack {
                Image(uiImage: item.titleImage)
                    .resizable()
                    .frame(
                        width: .titleImageWidth,
                        height: .titleImageHeight,
                        alignment: .center
                    )
                    .aspectRatio(contentMode: .fit)
                VStack {
                    Spacer()
                    RatingView(item: item)
                        .frame(
                            width: .ratingViewWidth,
                            height: .ratingViewHeight,
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
        return CatalogRowView.PreviewImageView(item: CatalogView.RowItem.mockedData[0])
            .previewLayout(.fixed(width: 130, height: 130))
    }
}
#endif
