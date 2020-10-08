//
//  RecommendationFilter.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 04.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let titlePadding: CGFloat = 20
    static let listSpacing: CGFloat = 10
    static let listLeading: CGFloat = 60
    static let listPaddingTop: CGFloat = 10
}

private extension LocalizedStringKey {
    static let recommendedTitle = LocalizedStringKey("Рекомендованное")
    static let recommendedOrder = LocalizedStringKey("Наиболее вам подходящие")
    static let basedOnRatingOrder = LocalizedStringKey("По рейтингу")
}

private extension Font {
    static let recomended = Font.title.bold()
}

// MARK: - View

struct RecommendationFilter: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack {
            HStack {
                Text(LocalizedStringKey.recommendedTitle)
                    .padding([.top, .leading], .titlePadding)
                    .font(.recomended)
                Spacer()
            }
            SingleCheckedRadioButton(
                spacing: .listSpacing,
                items: viewModel.catalogSortOrderItems,
                isScrollable: false,
                checkedItem: $viewModel.checkedCatalogSortOrderItem
            )
            .padding(.leading, .listLeading)
            .padding(.top, .listPaddingTop)

            Spacer()
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
