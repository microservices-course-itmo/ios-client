//
//  CatalogRowView+InfoView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension Image {
    static let heartFill = Image(systemName: "suit.heart.fill")
}

private extension Font {
    static let itemTitle: Font = .system(size: 16, weight: .medium)
    static let heart: Font = .system(size: 25)
    static let wineDescription: Font = .system(size: 13)
    static let compatibility: Font = .system(size: 11)
}

private extension Color {
    static let heartLiked: Color = .red
    static let heartNotLiked: Color = .gray
}

private extension CGFloat {
    static let retailerImageWidth: CGFloat = 80
    static let retailerImageLeading: CGFloat = 8
}

private extension LocalizedStringKey {
    static func compatibility(percentage: Int) -> LocalizedStringKey {
        return "Подходит вам на \(percentage)%"
    }

    static func wineDescription(country: String, color: String, wineAstringency: String, quantityLiters: Int) -> LocalizedStringKey {
        return "\(country), \(color), \(wineAstringency), \(quantityLiters) л"
    }
}

// MARK: - View

extension CatalogRowView {
    /// Catalog item info, price offer, compatibility and retailer view
    struct InfoView: View {

        let item: CatalogView.RowItem

        var body: some View {
            VStack {

                // Title and 'like' image
                HStack {
                    Text(item.title)
                        .font(.itemTitle)
                        .lineLimit(4)
                    Spacer()
                    Image.heartFill
                        .foregroundColor(heartColor)
                        .font(.heart)
                }

                Spacer()

                // Wine description
                HStack {
                    Text(wineDescriptionText)
                        .font(.wineDescription)
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                    Spacer()
                }

                Spacer()

                // Compatibility
                HStack {
                    Spacer()
                    Text(compatibilityText)
                        .font(.compatibility)
                }

                Spacer()

                // Price offer
                HStack {
                    Image(uiImage: item.retailerImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: .retailerImageWidth)
                        .padding(.leading, .retailerImageLeading)
                    Spacer()
                    DiscountView(item: item)
                }
            }
        }

        // MARK: Helpers

        private var heartColor: Color {
            return item.isLiked ? .heartLiked : .heartNotLiked
        }

        private var compatibilityText: LocalizedStringKey {
            return .compatibility(percentage: Int(item.chemistry))
        }

        private var wineDescriptionText: LocalizedStringKey {
            return .wineDescription(
                country: item.country,
                color: item.color.name,
                wineAstringency: item.wineAstringency.name,
                quantityLiters: Int(item.quantityLiters)
            )
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRowViewInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogRowView.InfoView(item: CatalogView.RowItem.mockedData[0])
            .previewLayout(.fixed(width: 274, height: 130))
    }
}
#endif
