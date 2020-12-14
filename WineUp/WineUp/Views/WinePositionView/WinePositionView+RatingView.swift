//
//  WinePositionView+Rating.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let starsRowBottom: CGFloat = 10
    static let starsSpacing: CGFloat = 2
}

private extension Image {
    static let starFill = Image(systemName: "star.fill")
    static let star = Image(systemName: "star")
}

private extension Color {
    static let burningStar: Color = .yellow
}

private extension Font {
    static let star: Font = .system(size: 14)
}

// MARK: - View

extension WinePositionView {
    /// Catalog item rating view (stars row)
    struct RatingView: View {

        let item: WinePosition

        var body: some View {
            ZStack {
                HStack {
                    HStack(spacing: .starsSpacing) {
                        ForEach(1..<6) { index in
                            image(forIndex: index)
                                .font(.star)
                                .foregroundColor(.burningStar)
                        }
                    }
                    .padding(.bottom, .starsRowBottom)
                }
            }
        }

        // MARK: Helpers

        private func image(forIndex index: Int) -> Image {
            return Float(index) <= item.rating ? .starFill : .star
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRowViewRatingView_Previews: PreviewProvider {
    static var previews: some View {
        let item = WinePosition.mockedData[0]
        return WinePositionView.RatingView(item: item)
            .previewLayout(.fixed(width: 240, height: 15))
    }
}
#endif
