//
//  FavoritesSortByView.swift
//  WineUp
//
//  Created by Александр Пахомов on 26.10.2020.
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

struct FavoritesSortByView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack {
            SingleCheckedRadioButton(
                spacing: .radioButtonSpacing,
                items: viewModel.sortByItems,
                isScrollable: false,
                isLineHidden: true,
                checkedItem: $viewModel.checkedSortByItems
            )
            .font(.radioButtonText)
            .padding(.leading, .radioButtonLeading)
            .padding(.top, .radioButtonPaddingTop)
        }
    }
}

// MARK: - RadioButtonItem

extension FavoritesSortByView.SortByItem: RadioButtonItem {
    var id: SortBy {
        sortBy
    }

    var textRepresentation: LocalizedStringKey {
        switch sortBy {
        case .recommended:
            return .recommendedOrder
        case .baseedOnRating:
            return .basedOnRatingOrder
        case .priceAsc:
            return .priceAsc
        case .priceDesc:
            return .priceDesc
        @unknown default:
            fatalError("Unexpected sort order")
        }
    }
}

// MARK: - Preview

#if DEBUG
struct FavoritesSortByView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesSortByView(viewModel: .init())
            .previewLayout(.fixed(width: 420, height: 300))
    }
}
#endif
