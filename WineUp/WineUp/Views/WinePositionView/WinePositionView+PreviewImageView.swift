//
//  WinePositionView+PreviewImageView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let titleImageWidth: CGFloat = 220
    static let titleImageHeight: CGFloat = 260
    static let discountFlagTextWidth: CGFloat = 50
    static let discountFlagTextHeight: CGFloat = 10
    static let discountFlagOffset: CGFloat = 145

}

private extension Image {
    static let discount = Image(systemName: "bookmark.fill")
}

private extension Font {
    static let bookmark: Font = .system(size: 75)
}

private extension Color {
    static let discountColor = Color(red: 145 / 255, green: 22 / 255, blue: 52 / 255)
}

// MARK: - View

extension WinePositionView {
    /// Catalog item title image and rating overlay view
    struct PreviewImageView: View {

        let item: WinePosition

        var body: some View {
            ZStack(alignment: .leading) {

                if item.originalPriceRub != item.priceWithDiscount {
                    Text("-\(String(Int(item.discountPercents)))% ")
                        .italic()
                        .bold()
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(-3))
                        .frame(width: .discountFlagTextWidth, height: .discountFlagTextHeight, alignment: .leading)
                        .background(
                            Image.discount .font(.bookmark)
                                .foregroundColor(Color .discountColor).rotationEffect(.degrees(270))
                        )
                        .offset(x: .discountFlagOffset)
                }

                Image(uiImage: item.titleImage)
                    .resizable()
                    .frame(
                        width: .titleImageWidth,
                        height: .titleImageHeight,
                        alignment: .center
                    )
                    .aspectRatio(contentMode: .fit)
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRowViewPreviewImageView_Previews: PreviewProvider {
    static var previews: some View {
        return WinePositionView.PreviewImageView(item: WinePosition.mockedData[1])
            .previewLayout(.fixed(width: 260, height: 260))
    }
}
#endif
