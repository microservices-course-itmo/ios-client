//
//  WinePositionDetailsView+SuggestionsList.swift
//  WineUp
//
//  Created by Александр Пахомов on 31.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension LocalizedStringKey {
    static let suggestionsListTitleFirst = LocalizedStringKey("Мы подобрали для вас")
    static let suggestionsListTitleSecond = LocalizedStringKey("схожие вина:")
    static let leftArrow = LocalizedStringKey("\u{2190}")
    static let rightArrow = LocalizedStringKey("\u{2192}")
}
// MARK: - View

extension WinePositionDetailsView {
    struct SuggestionsList: View {
        let winePosition: WinePosition
        let details: WinePosition.Details
        let textFont: Font = .system(size: 25)
        let arrowFont: Font = .system(size: 40)

        var body: some View {
            VStack(alignment: .center) {
                VStack(alignment: .center) {
                    Text(LocalizedStringKey.suggestionsListTitleFirst)
                        .font(textFont)
                    Text(LocalizedStringKey.suggestionsListTitleSecond)
                        .font(textFont)
                }.padding(.top, -20)

                WinePositionView(item: winePosition)

                HStack(alignment: .center, spacing: 30) {
                    Button(action: {}){
                        Text(LocalizedStringKey.leftArrow).font(arrowFont)
                    }.buttonStyle(CircleButtonStyle())
                    Button(action: {}){
                        Text(LocalizedStringKey.rightArrow).font(arrowFont)
                    }.buttonStyle(CircleButtonStyle())
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
