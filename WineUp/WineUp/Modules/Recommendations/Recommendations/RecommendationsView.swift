//
//  RecommendationsView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 29.03.2021.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let rootVStackSpacing: CGFloat = 0
    static let wineCardsSpacing: CGFloat = 10
}

private extension LocalizedStringKey {
    static let title = LocalizedStringKey("Рекомендуемое вам")
}

// MARK: - View

/// Stack of filters and list of catalog offers
struct RecommendationsView: View {

    @StateObject var viewModel: ViewModel
    @State private var searchText: String = ""

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    SearchBarView(placeholder: "Введите название", text: $searchText)
                        .padding(8)

                    RecommendationsTopView()
                        .padding(8)

                    if let recommended = viewModel.recommendedWinePositions.value {
                        WinePositionDetailsView.SuggestionsList(
                            title: Text("Рекомендуемое вам"),
                            winePositions: recommended,
                            onLikeButtonTap: { _ in }
                        )
                        .padding(.horizontal, 8)
                        .padding(.bottom, 32)
                    }

                    if let popular = viewModel.popularWinePositions.value {
                        WinePositionDetailsView.SuggestionsList(
                            title: Text("Популярное"),
                            winePositions: popular,
                            onLikeButtonTap: { _ in }
                        )
                        .padding(.horizontal, 8)
                        .padding(.bottom, 48)
                    }

                    RecommendationsBottomView()
                }
                .frame(width: proxy.size.width)
                .padding(.vertical, 8)
            }
        }
        .background(Color(white: 0.96).ignoresSafeArea())
        .onAppear(perform: viewModel.loadRecommended)
        .onAppear(perform: viewModel.loadPopular)
        .navigationBarHidden(true)
    }
}

// MARK: - Preview

#if DEBUG
struct RecommendationsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecommendationsView(viewModel: .preview)
        }
    }
}
#endif
