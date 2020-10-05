//
//  RecommendationFilter.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 04.10.2020.
//

import SwiftUI

private extension CGFloat {
    static let titlePadding: CGFloat = 20
    static let listSpacing: CGFloat = 10
    static let listLeading: CGFloat = 60
    static let listPaddingTop: CGFloat = 10
}

struct RecommendationFilter: View {

    // MARK: - View

    var body: some View {
        VStack {
            HStack {
                Text("Рекомендованное")
                    .padding([.top, .leading], .titlePadding)
                    .font(Font.title.bold())
                Spacer()
            }
            RecommendationFilterList(viewModel: listViewModel,
                                     spacing: .listSpacing)
                .padding(.leading, .listLeading)
                .padding(.top, .listPaddingTop)
            Spacer()
        }
    }

    // MARK: - Private

    private var listViewModel: RecommendationFilterList.ViewModel {
        return .init(variants: ["Наиболее вам подходящие",
                                "По рейтингу"])
    }
}

#if DEBUG
struct RecommendationFilter_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationFilter()
            .previewLayout(.fixed(width: 420, height: 300))
    }
}
#endif
