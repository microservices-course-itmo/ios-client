//
//  WinePositionDetailsView.swift
//  WineUp
//
//  Created by Александр Пахомов on 29.10.2020.
//

import SwiftUI

// MARK: - View

struct WinePositionDetailsView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack {
                WinePositionView(item: viewModel.winePosition)
                    .padding()

                DetailsView(winePosition: viewModel.winePosition, details: viewModel.details)
                    .padding(.vertical)

                ReviewsList(winePosition: viewModel.winePosition, details: viewModel.details)
                    .padding(.vertical)

                SuggestionsList(winePosition: viewModel.winePosition, details: viewModel.details)
                    .padding(.vertical)
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct WinePositionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WinePositionDetailsView(viewModel: .preview)
        }
    }
}
#endif
