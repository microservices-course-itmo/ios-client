//
//  CatalogRowView+PreviewImageView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let titleImageWidth: CGFloat = 220
    static let titleImageHeight: CGFloat = 260
    static let ratingViewWidth: CGFloat = 110
    static let ratingViewHeight: CGFloat = 50
}

private extension Color {
    static let discountColor: Color = Color(red: 145 / 255, green: 22 / 255, blue: 52 / 255)
}

// MARK: - View

extension CatalogRowView {
    /// Catalog item title image and rating overlay view
    struct PreviewImageView: View {

        let item: CatalogView.RowItem

        var body: some View {
            VStack(alignment: .center, spacing: 2.0) {
                ZStack(alignment: .leading)  {
                    Image(uiImage: item.titleImage)
                        .resizable()
                        .frame(
                            width: .titleImageWidth,
                            height: .titleImageHeight,
                            alignment: .center
                        )
                        .aspectRatio(contentMode: .fit)

                    Text("-\(String(Int(item.discountPercents)))%").italic().foregroundColor(.white).rotationEffect(.degrees(-5))


                        .frame(width: 50, height: 50, alignment: .center).background(Circle().fill(Color.discountColor))
                        .offset(x: 55)
                }
                Text("\(item.year) г.")
                    .multilineTextAlignment(.trailing)
                    .padding(.horizontal, 1.0)

            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRowViewPreviewImageView_Previews: PreviewProvider {
    static var previews: some View {
        return CatalogRowView.PreviewImageView(item: CatalogView.RowItem.mockedData[0])
            .previewLayout(.fixed(width: 260, height: 260))
    }
}
#endif
