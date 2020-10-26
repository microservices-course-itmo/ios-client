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
    static let star = Image(systemName: "star")
}

private extension LocalizedStringKey {
    static let ratingTitle = LocalizedStringKey("ОЦЕНКА ЭКСПЕРТОВ")
}

private extension Color {
    static let backgroundVeil = Color(white: 1, opacity: 0.6)
    static let burningStar: Color = .yellow
}

private extension Font {
    static let ratingTitle: Font = .system(size: 11, weight: .light)
    static let star: Font = .system(size: 11)
}

// MARK: - View

extension CatalogRowView {
    /// Catalog item rating view (stars row)
    struct RatingView: View {

        let item: CatalogView.RowItem

        var body: some View {
            ZStack {
                HStack {
                    HStack(spacing: 2) {
                        ForEach(1..<6) { index in
                            image(forIndex: index)
                                .font(.star)
                                .foregroundColor(.burningStar)
                        }
                    }
                    .padding(.vertical)
                    Text(LocalizedStringKey.ratingTitle)
                        .font(.ratingTitle)
                        .foregroundColor(Color.gray)
                        .padding(.top, 2.0)
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
        let item = CatalogView.RowItem.mockedData[0]
        return CatalogRowView.RatingView(item: item)
            .previewLayout(.fixed(width: 240, height: 15))
    }
}
#endif
