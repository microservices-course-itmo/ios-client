//
//  RecommendationFilter.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 04.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let radioButtonSpacing: CGFloat = 0
    static let radioButtonLeading: CGFloat = 16
    static let radioButtonPaddingTop: CGFloat = 8
}

private extension LocalizedStringKey {
    static let recommendedOrder = LocalizedStringKey("Наиболее вам подходящие")
    static let basedOnRatingOrder = LocalizedStringKey("По рейтингу")
    static let priceAsc = LocalizedStringKey("По возрастанию цены")
    static let priceDesc = LocalizedStringKey("По убыванию цены")
}

private extension Font {
    static let radioButtonText = Font.system(size: 15)
}

// MARK: - View

struct RecommendationFilter: View {

    let allCases: [SortBy] = [.recommended, .basedOnRating]
    @Binding var selected: SortBy

    var body: some View {
        VStack {
            SingleCheckedRadioButton(
                spacing: .radioButtonSpacing,
                items: allCases,
                isScrollable: false,
                isLineHidden: true,
                checkedItem: $selected.toOptional(defaultValue: .basedOnRating)
            )
            .font(.radioButtonText)
            .padding(.leading, .radioButtonLeading)
            .padding(.top, .radioButtonPaddingTop)
        }
    }
}

// MARK: - RadioButtonItem

extension SortBy: RadioButtonItem {
    var id: SortBy {
        self
    }

    var textRepresentation: LocalizedStringKey {
        switch self {
        case .recommended:
            return .recommendedOrder
        case .basedOnRating:
            return .basedOnRatingOrder
        case .priceAsc:
            return .priceAsc
        case .priceDesc:
            return .priceDesc
        }
    }
}

// MARK: - Preview

#if DEBUG
struct RecommendationFilter_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationFilter(selected: .constant(.basedOnRating))
            .previewLayout(.fixed(width: 420, height: 300))
    }
}
#endif
