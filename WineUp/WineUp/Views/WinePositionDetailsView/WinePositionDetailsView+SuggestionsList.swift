//
//  WinePositionDetailsView+SuggestionsList.swift
//  WineUp
//
//  Created by Александр Пахомов on 31.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension LocalizedStringKey {
    static let suggestionsListTitle = LocalizedStringKey("Мы подобрали для вас\nсхожие вина:")

    static let leftArrow = LocalizedStringKey("\u{2190}")
    static let rightArrow = LocalizedStringKey("\u{2192}")
}

private extension Font {
    static let suggestionsListTitle: Font = .system(size: 25)
    static let arrow: Font = .system(size: 40)
}

// MARK: - View

extension WinePositionDetailsView {
    struct SuggestionsList: View {

        let winePosition: WinePosition
        let details: WinePosition.Details

        var body: some View {
            
            VStack(alignment: .center) {
                Text(LocalizedStringKey.suggestionsListTitle)
                    .font(.suggestionsListTitle)
                    .multilineTextAlignment(.center)
                    .padding()

                WinePositionView(item: winePosition)

                HStack(alignment: .center, spacing: 30) {
                    Button(action: {}) {
                        Text(LocalizedStringKey.leftArrow)
                            .font(.arrow)
                    }
                    .circleStyled()

                    Button(action: {}) {
                        Text(LocalizedStringKey.rightArrow)
                            .font(.arrow)
                    }
                    .circleStyled()
                }
            }
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
