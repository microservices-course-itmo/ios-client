//
//  CatalogRowView+Rating.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

// MARK: - View

extension CatalogRowView {
    /// Catalog item rating view (stars row)
    struct RatingView: View {

        let item: CatalogView.Item

        var body: some View {
            ZStack {
                Color(white: 1, opacity: 0.6).ignoresSafeArea()
                VStack {
                    Text("Оценка экспертов:")
                        .font(.system(size: 11))
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                    Spacer()
                    HStack {
                        ForEach(1..<6) { index in
                            Image(systemName: "star.fill")
                                .font(.system(size: 13))
                                .foregroundColor(color(forIndex: index))
                        }
                    }
                    .padding(.bottom, 10)
                }
            }
        }
    }
}

// MARK: - Helpers

private extension CatalogRowView.RatingView {
    func color(forIndex index: Int) -> Color {
        return Float(index) <= item.rating ? .black : .gray
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRowViewRatingView_Previews: PreviewProvider {
    static var previews: some View {
        let item = CatalogView.Item.mockedData[0]
        return CatalogRowView.RatingView(item: item)
            .previewLayout(.fixed(width: 120, height: 50))
    }
}
#endif
