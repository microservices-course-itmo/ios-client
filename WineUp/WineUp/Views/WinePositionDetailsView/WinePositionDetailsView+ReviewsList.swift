//
//  WinePositionDetailsView+ReviewsList.swift
//  WineUp
//
//  Created by Александр Пахомов on 31.10.2020.
//

import SwiftUI

// MARK: - Constants

// MARK: - View

extension WinePositionDetailsView {
    struct ReviewsList: View {
        let winePosition: WinePosition
        let details: WinePosition.Details

        var body: some View {
            VStack(spacing: 25) {
                Text("Отзывы")
                    .font(.system(size: 25))

                VStack(spacing: 16) {
                    ForEach(details.reviews) { review in
                        WineReviewCardView(review: review)
                            .padding(.horizontal, 16)
                    }
                }

                Button(action: {}, label: {
                    Text("Больше отзывов")
                })
                .defaultStyled(isDisabled: false)
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct WinePositionDetailsViewReviewsList_Previews: PreviewProvider {
    private static let winePosition = WinePosition.mockedData[0]

    static var previews: some View {
        WinePositionDetailsView.ReviewsList(winePosition: winePosition, details: winePosition.details)
    }
}
#endif
