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

struct RecommendationFilter: IFilterView {

    // MARK: - IFilterView

    var title: String { "Рекомендованное" }

    var content: AnyView {
        AnyView(
            VStack {
                RecommendationFilterList(viewModel: listViewModel,
                                         spacing: .listSpacing)
                    .padding(.top, .listPaddingTop)
            }
        )
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
        RecommendationFilter().content
            .previewLayout(.fixed(width: 420, height: 300))
    }
}
#endif
