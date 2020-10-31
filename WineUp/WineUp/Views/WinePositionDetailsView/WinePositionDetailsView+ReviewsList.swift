//
//  WinePositionDetailsView+ReviewsList.swift
//  WineUp
//
//  Created by Александр Пахомов on 31.10.2020.
//

import SwiftUI

// MARK: - Constants

// MARK: - View

extension WinePositionDetailsView {
    struct ReviewsList: View {
        let winePosition: WinePosition
        let details: WinePosition.Details

        var body: some View {
            // TODO: Missing implementation
            Color.green
                .frame(width: UIScreen.main.bounds.width, height: 400, alignment: .center)
                .overlay(Text("Reviews"))
        }
    }
}

// MARK: - Preview

#if DEBUG
struct WinePositionDetailsViewReviewsList_Previews: PreviewProvider {
    private static let winePosition = WinePosition.mockedData[0]

    static var previews: some View {
        WinePositionDetailsView.ReviewsList(winePosition: winePosition, details: winePosition.details)
    }
}
#endif
