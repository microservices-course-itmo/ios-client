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

    var body: some View {
        content()
            .navigationBarHidden(true)
    }

    // MARK: Helpers

    @ViewBuilder
    private func content() -> some View {
        switch viewModel.recommendationsItems {
        case let .failed(error):
            Text(error.description)
        case .notRequested:
            Text("Not requested")
                .onAppear(perform: viewModel.loadItems)
        case .loaded, .isLoading:
            let winePositions = viewModel.recommendationsItems.value ?? []
            winePositionsContent(winePositions: winePositions)
                .activity(triggers: viewModel.recommendationsItems)
        }
    }

    private func winePositionsContent(winePositions: [WinePosition]) -> some View {
        VStack(spacing: .rootVStackSpacing) {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    Text(.title)
                        .font(.title)
                        .padding()
                        .horizontallySpanned(alignment: .leading)

                    ForEach(winePositions) { item in
                        NavigationLink(
                            destination: WinePositionDetailsView(
                                viewModel: viewModel.winePositionDetailsViewModelFor(item)),
                            tag: item.id,
                            selection: $viewModel.selectedRecommendationItemId, label: {
                                WinePositionView(item: item, onLikeButtonTap: { viewModel.toggleLike(of: item) })
                                    .foregroundColor(.black)
                                    .padding()
                                    .cardStyled()
                                    .padding(.wineCardsSpacing)
                            }
                        )
                    }
                }
            }
        }
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
