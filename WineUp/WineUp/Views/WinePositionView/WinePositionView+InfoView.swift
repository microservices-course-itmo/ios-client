//
//  WinePositionView+InfoView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension Image {
    static let heartFill = Image(systemName: "suit.heart.fill")
    static let compatibilityIcon = Image("iconstar")
    static let shopIcon = Image("iconshop")
    static let wineIcon = Image("iconwine")
}

private extension Font {
    static let itemTitle: Font = .system(size: 17, weight: .black)
    static let heart: Font = .system(size: 25)
    static let wineDescription: Font = .system(size: 15)
}

private extension Color {
    static let heartLiked = Color(red: 145 / 255, green: 22 / 255, blue: 52 / 255)
    static let heartNotLiked: Color = .gray
}

private extension LocalizedStringKey {
    static func compatibilityDescription(percentage: Int) -> LocalizedStringKey {
        return "Подходит вам на \(percentage)%"
    }

    static func wineDescription(description: String) -> LocalizedStringKey {
        return "\(description)"
    }

    static func wineCharacteristicsDescription(color: String, wineAstringency: String) -> LocalizedStringKey {
        return "\(color), \(wineAstringency)"
    }
}

// MARK: - View

extension WinePositionView {
    /// Catalog item info, price offer, compatibility and retailer view
    struct InfoView: View {

        let item: WinePosition

        var body: some View {
            VStack(alignment: .leading) {
                //TODO вынести в отдельный view

                Image.heartFill
                    .foregroundColor(heartColor)
                    .font(.heart)
                    .horizontallySpanned(alignment: .trailing)

                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        WinePositionView.RatingView(item: item)
                            .padding(.vertical)
                            .frame(width: 200.0, height: 10.0)
                    }
                    .padding(.trailing)

                    Text("\(item.title), \(String(format: "%.2f", item.quantityLiters))л")
                        .font(.itemTitle)
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                        .padding(.trailing, 15.0)
                }

                Divider()

                //TODO Вынести в отдельный view
                VStack(alignment: .leading, spacing: 4.0) {
                    HStack {
                        Image(item.country)
                            .resizable()
                            .frame(width: 25.0, height: 16.0)

                        Text(countryText)
                            .font(.wineDescription)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Image.wineIcon
                            .resizable()
                            .frame(width: 25.0, height: 25.0)

                        Text(characteristicsText)
                            .font(.wineDescription)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Image.compatibilityIcon
                            .resizable()
                            .frame(width: 25.0, height: 25.0)

                        Text(compatibilityText)
                            .font(.wineDescription)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Image.shopIcon
                            .resizable()
                            .frame(width: 25.0, height: 25.0)

                        Text(retailerText)
                            .font(.wineDescription)
                            .foregroundColor(.gray)
                    }
                }

                WinePositionView.DiscountView(item: item)
            }
        }

        // MARK: Helpers

        private var heartColor: Color {
            return item.isLiked ? .heartLiked : .heartNotLiked
        }

        private var compatibilityText: LocalizedStringKey {
            return .compatibilityDescription(percentage: Int(item.chemistry))
        }

        private var retailerText: LocalizedStringKey {
            return .wineDescription(description: item.retailerName)
        }

        private var countryText: LocalizedStringKey {
            return .wineDescription(description: item.country)
        }

        private var characteristicsText: LocalizedStringKey {
            return .wineCharacteristicsDescription(color: item.color.name,
                                                   wineAstringency: item.wineAstringency.name)

        }
        private var shopText: LocalizedStringKey {
            return .compatibilityDescription(percentage: Int(item.chemistry))
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRowViewInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WinePositionView.InfoView(item: WinePosition.mockedData[1])
            .previewLayout(.fixed(width: 274, height: 430))
    }
}
#endif
