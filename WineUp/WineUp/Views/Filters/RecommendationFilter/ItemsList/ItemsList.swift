//
//  RecommendationFilterList.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 04.10.2020.
//

import SwiftUI

// MARK: - View

extension RecommendationFilter {

    struct ItemsList: View {

        @ObservedObject var viewModel: ViewModel
        var spacing: CGFloat?

        var body: some View {
            VStack(spacing: spacing) {
                ForEach(viewModel.items) { item in
                    ItemView(item: item, pickedItem: $viewModel.pickedItem)
                        .onTapGesture {
                            viewModel.didItemTapped(item: item)
                        }
                }
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct RecommendationFilterViewItemsList_Previews: PreviewProvider {

    static var previews: some View {
        RecommendationFilter.ItemsList(viewModel: .init(orders: [.recommended, .baseedOnRating]))
            .previewLayout(.fixed(width: 420, height: 300))
    }
}
#endif
