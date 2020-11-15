//
//  WinePositionDetailsView+SuggestionsList.swift
//  WineUp
//
//  Created by Александр Пахомов on 31.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let suggestionWinePositionHeight: CGFloat = 650
}

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

        @State private var currentSuggestionIndex = 0 {
            didSet {
                currentSeggestionIndexDidSet(currentSuggestionIndex)
            }
        }
        @State private var isLeftArrowEnabled = false
        @State private var isRightArrowEnabled = true

        var body: some View {
            VStack(alignment: .center) {
                Text(LocalizedStringKey.suggestionsListTitle)
                    .font(.suggestionsListTitle)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()

                Pager(
                    pageCount: details.suggestions.count,
                    currentIndex: $currentSuggestionIndex,
                    content: {
                        ForEach(details.suggestions) { suggestedWinePosition in
                            WinePositionView(item: suggestedWinePosition)
                                .cardStyled()
                        }
                    }
                )
                // Unfortunetely GeometryReader which is used inside of Pager cannot increase its own height based on children's
                // So explicit height setting is needed
                .frame(height: .suggestionWinePositionHeight)
                .animation(.easeInOut(duration: 0.35), value: currentSuggestionIndex)

                HStack(alignment: .center, spacing: 30) {
                    Button(action: arrowLeftButtonDidTap) {
                        Text(LocalizedStringKey.leftArrow)
                            .font(.arrow)
                    }
                    .circleStyled(isDisabled: !isLeftArrowEnabled)

                    Button(action: arrowRightButtonDidTap) {
                        Text(LocalizedStringKey.rightArrow)
                            .font(.arrow)
                    }
                    .circleStyled(isDisabled: !isRightArrowEnabled)
                }
            }
        }

        // MARK: - Helpers

        private func arrowLeftButtonDidTap() {
            currentSuggestionIndex -= 1
        }

        private func arrowRightButtonDidTap() {
            currentSuggestionIndex += 1
        }

        private func currentSeggestionIndexDidSet(_ index: Int) {
            isLeftArrowEnabled = index > 0
            isRightArrowEnabled = index < details.suggestions.count - 1
        }
    }
}

// MARK: - Preview

#if DEBUG
struct WinePositionDetailsViewSuggestionsList_Previews: PreviewProvider {
    private static let winePosition = WinePosition.mockedData[0]

    static var previews: some View {
        WinePositionDetailsView.SuggestionsList(winePosition: winePosition, details: winePosition.details)
            .previewLayout(.fixed(width: 414, height: 900))
    }
}
#endif
