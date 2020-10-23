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
}

private extension Font {
    static let radioButtonText = Font.system(size: 15)
}

// MARK: - View

struct RecommendationFilter: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack {
            SingleCheckedRadioButton(
                spacing: .radioButtonSpacing,
                items: viewModel.catalogSortOrderItems,
                isScrollable: false,
                isLineHidden: true,
                checkedItem: $viewModel.checkedCatalogSortOrderItem
            )
            .font(.radioButtonText)
            .padding(.leading, .radioButtonLeading)
            .padding(.top, .radioButtonPaddingTop)
        }
    }
}

// MARK: - RadioButtonItem

extension RecommendationFilter.CatalogSortOrderItem: RadioButtonItem {
    var id: CatalogSortOrder {
        sortOrder
    }

    var textRepresentation: LocalizedStringKey {
        switch sortOrder {
        case .recommended:
            return .recommendedOrder
        case .baseedOnRating:
            return .basedOnRatingOrder
        }
    }
}

// MARK: - Preview

#if DEBUG
struct RecommendationFilter_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationFilter(viewModel: .init())
            .previewLayout(.fixed(width: 420, height: 300))
    }
}
#endif
