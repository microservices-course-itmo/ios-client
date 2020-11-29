//
//  WineReviewCardView.swift
//  WineUp
//
//  Created by George on 09.11.2020.
//

import SwiftUI

// MARK: - Private extensions

private extension Image {
    static let starFill = Image(systemName: "star.fill")
    static let star = Image(systemName: "star")
}

private extension Font {
    static let star: Font = .system(size: 14)
    static let review: Font = .system(size: 16)
}

private extension CGFloat {
    static let starsRowBottom: CGFloat = 10
    static let starsSpacing: CGFloat = 2
}

private extension Color {
    static let burningStar: Color = .yellow
}

struct WineReviewCardView: View {

    // MARK: - Object

    let review: WinePosition.Details.Review

    // MARK: - View

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(review.reviewerFullName)
                        .font(.title3)
                    Spacer()
                    HStack(spacing: .starsSpacing) {
                        ForEach(1..<6) { index in
                            image(forIndex: index)
                                .font(.star)
                                .foregroundColor(.burningStar)
                        }
                    }
                }
                .padding(.bottom, 8)
                HStack {
                    Text("«" + "\(review.review)" + "»")
                        .italic()
                        .foregroundColor(Color(white: 0.33))
                        .font(.review)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                .padding(.bottom, 8)

                HStack {
                    Spacer()
                    Text(review.timestamp.getDate() ?? "")
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.caption)
                }
            }
            .padding()
        }
        .background(Color.white)
        // Card style with no shadow
        .cardStyled(shadowColor: Color.clear)
    }

    // MARK: - Private Methods

    private func image(forIndex index: Int) -> Image {
        return Float(index) <= review.rating ? .starFill : .star
    }
}

// MARK: - Preview

#if DEBUG
struct WineReviewCardView_Previews: PreviewProvider {
    private static let review = WinePosition.mockedData[0].details.reviews[0]

    static var previews: some View {
        WineReviewCardView(review: review)
    }
}
#endif
