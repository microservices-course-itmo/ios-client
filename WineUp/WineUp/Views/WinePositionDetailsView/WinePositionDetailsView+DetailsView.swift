//
//  WinePositionDetailsView+DetailsView.swift
//  WineUp
//
//  Created by Александр Пахомов on 31.10.2020.
//

import SwiftUI
import struct Kingfisher.KFImage

// MARK: - Constants

private extension CGFloat {
    static let backgroundImageHeight: CGFloat = 208
    static let forkImageWidth: CGFloat = 48
    static let forkLeading: CGFloat = 10
    static let tasteDescriptionLeading: CGFloat = 8
    static let dishSuggestionsLeading: CGFloat = 16
    static let dishSuggestionsTrailing: CGFloat = 35
    static let bottleHorizontalOverlap: CGFloat = -40
    static let textVStackSpacing: CGFloat = 16
    static let bottleWidth: CGFloat = 130
}

private extension Color {
    static let text = Color(white: 0.2)
}

private extension Font {
    static let tasteDescription: Font = .system(size: 14)
    static let dishSuggestions: Font = .system(size: 12, weight: .light)
}

// MARK: - View

extension WinePositionDetailsView {
    struct DetailsView: View {

        let winePosition: WinePosition
        let details: WinePosition.Details

        var body: some View {
            ZStack {
                VStack {
                    Spacer()
                    Spacer()

                    Image("Vines")
                        .resizable()
                        .scaledToFill()
                        .frame(height: .backgroundImageHeight)

                    Spacer()

                    Image("Fork")
                        .horizontallySpanned(alignment: .leading)
                        .frame(height: .forkImageWidth)
                        .padding(.leading, .forkLeading)
                }

                HStack(spacing: .bottleHorizontalOverlap) {
                    VStack(alignment: .leading, spacing: .textVStackSpacing) {
                        Text(details.tasteDescription)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.tasteDescription)
                            .foregroundColor(.text)
                            .padding(.trailing)
                            .padding(.leading, .tasteDescriptionLeading)

                        Spacer(minLength: .backgroundImageHeight)

                        Text(details.dishSuggestions)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.dishSuggestions)
                            .foregroundColor(.text)
                            .frame(height: .forkImageWidth)
                            .padding(.trailing, .dishSuggestionsTrailing)
                            .padding(.leading, .dishSuggestionsLeading)
                    }
                    .padding(.horizontal)

                    Spacer()

                    KFImage.fromUniverseUrl(winePosition.titleImageUrl)
                        .resizable(resizingMode: .stretch)
                        .scaledToFill()
                        .frame(width: .bottleWidth)
                }
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct WinePositionDetailsViewDetailsView_Previews: PreviewProvider {
    private static let winePosition = WinePosition.mockedData[0]

    static var previews: some View {
        Group {
            WinePositionDetailsView.DetailsView(winePosition: winePosition, details: winePosition.details)
        }
        .previewLayout(.fixed(width: 414, height: 350))
    }
}
#endif
