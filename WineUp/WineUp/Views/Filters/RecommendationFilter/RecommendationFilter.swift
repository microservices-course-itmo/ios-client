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
    static let recomended = LocalizedStringKey("Рекомендованное")
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
                Text(LocalizedStringKey.recomended)
                    .padding([.top, .leading], .titlePadding)
                    .font(.recomended)
                Spacer()
            }
            ItemsList(viewModel: viewModel.listViewModel,
                      spacing: .listSpacing)
                .padding(.leading, .listLeading)
                .padding(.top, .listPaddingTop)
            Spacer()
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
