//
//  WinePositionDetailsView+SuggestionsList.swift
//  WineUp
//
//  Created by Александр Пахомов on 31.10.2020.
//

import SwiftUI

// MARK: - Constants

// MARK: - View

extension WinePositionDetailsView {
    struct SuggestionsList: View {
        let winePosition: WinePosition
        let details: WinePosition.Details

        var body: some View {
            // TODO: Missing implementation
            Color.blue
                .frame(width: UIScreen.main.bounds.width, height: 400, alignment: .center)
                .overlay(Text("Suggestions"))
        }
    }
}

// MARK: - Preview

#if DEBUG
struct WinePositionDetailsViewSuggestionsList_Previews: PreviewProvider {
    private static let winePosition = WinePosition.mockedData[0]

    static var previews: some View {
        WinePositionDetailsView.SuggestionsList(winePosition: winePosition, details: winePosition.details)
    }
}
#endif
