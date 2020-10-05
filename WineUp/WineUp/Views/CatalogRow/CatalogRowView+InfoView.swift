//
//  CatalogRowView+InfoView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - View

extension CatalogRowView {
    /// Catalog item info, price offer, compatibility and retailer view
    struct InfoView: View {

        let item: CatalogView.Item

        var body: some View {
            VStack {

                // Title and 'like' image
                HStack {
                    Text(item.title)
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .lineLimit(4)
                    Spacer()
                    Image(systemName: "suit.heart.fill")
                        .foregroundColor(heartColor)
                        .font(.system(size: 25))
                }

                Spacer()

                // Wine description
                HStack {
                    Text(wineDescriptionText)
                        .font(.system(size: 13))
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                    Spacer()
                }

                Spacer()

                // Compatibility
                HStack {
                    Spacer()
                    Text(compatibilityText)
                        .font(.system(size: 11))
                }

                Spacer()

                // Price offer
                HStack {
                    Image(uiImage: item.retailerImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                        .padding(.leading, 8)
                    Spacer()
                    DiscountView(item: item)
                }
            }
        }
    }
}

// MARK: - Helpers

private extension CatalogRowView.InfoView {
    var heartColor: Color {
        return item.isLiked ? .red : .gray
    }

    var compatibilityText: String {
        return "Подходит вам на \(Int(item.chemistry))%"
    }

    var wineDescriptionText: String {
        return "\(item.country), \(item.color.name), \(item.wineAstringency.name), \(item.quantityLiters) л"
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRowViewInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogRowView.InfoView(item: CatalogView.Item.mockedData[0])
            .previewLayout(.fixed(width: 274, height: 130))
    }
}
#endif
