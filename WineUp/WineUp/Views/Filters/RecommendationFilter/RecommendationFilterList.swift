//
//  RecommendationFilterList.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 04.10.2020.
//

import SwiftUI

struct RecommendationFilterList: View {

    // Properties
    @ObservedObject var viewModel: ViewModel
    var spacing: CGFloat?

    // MARK: - View

    var body: some View {
        VStack(spacing: spacing) {
            ForEach(viewModel.variants) { item in
                RecommendationItemView(item: item,
                                       pickedItem: $viewModel.pickedItem)
                    .onTapGesture {
                        viewModel.didItemTapped(item: item)
                    }
            }
        }
    }
}

#if DEBUG
struct RecommendationFilterList_Previews: PreviewProvider {

    static var previews: some View {
        RecommendationFilterList(viewModel: .init(variants: ["Наиболее вам подходящие",
                                                             "По рейтингу"]))
            .previewLayout(.fixed(width: 420, height: 300))
    }
}
#endif
