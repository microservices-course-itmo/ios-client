//
//  CatalogRowView+Rating.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let ratingTitleTop: CGFloat = 10
    static let starsRowBottom: CGFloat = 10
}

private extension Image {
    static let starFill = Image(systemName: "star.fill")
}

private extension LocalizedStringKey {
    static let ratingTitle = LocalizedStringKey("Оценка экспертов:")
}

private extension Color {
    static let backgroundVeil = Color(white: 1, opacity: 0.6)
    static let burningStar: Color = .black
    static let normalStar: Color = .gray
}

private extension Font {
    static let ratingTitle: Font = .system(size: 11, weight: .semibold)
    static let star: Font = .system(size: 13)
}

// MARK: - View

extension CatalogRowView {
    /// Catalog item rating view (stars row)
    struct RatingView: View {

        let item: CatalogView.RowItem

        var body: some View {
            ZStack {
                Color.backgroundVeil.ignoresSafeArea()
                VStack {
                    Text(LocalizedStringKey.ratingTitle)
                        .font(.ratingTitle)
                        .padding(.top, .ratingTitleTop)
                    Spacer()
                    HStack {
                        ForEach(1..<6) { index in
                            Image.starFill
                                .font(.star)
                                .foregroundColor(color(forIndex: index))
                        }
                    }
                    .padding(.bottom, .starsRowBottom)
                }
            }
        }

        // MARK: Helpers

        private func color(forIndex index: Int) -> Color {
            return Float(index) <= item.rating ? .burningStar : .normalStar
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRowViewRatingView_Previews: PreviewProvider {
    static var previews: some View {
        let item = CatalogView.RowItem.mockedData[0]
        return CatalogRowView.RatingView(item: item)
            .previewLayout(.fixed(width: 120, height: 50))
    }
}
#endif
