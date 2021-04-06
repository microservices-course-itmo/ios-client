//
//  RecommendationsBottomView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.04.2021.
//

import SwiftUI

private extension LocalizedStringKey {
    static let aboutTitle = LocalizedStringKey("Немного о нашем\nприложении")
    static let aboutShops = LocalizedStringKey("Более 5000 магазинов\nв Москве и Санкт-Петербурге")
    static let aboutWines = LocalizedStringKey("Более 40000 вин\nв нашем каталоге")
    static let aboutUsers = LocalizedStringKey("512 пользователей,\nкоторые расскажут больше о вине")
}

struct RecommendationsBottomView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 44) {
            Text(LocalizedStringKey.aboutTitle)
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding(.bottom, -16)

            detailsView(imageName: "aboutShops", text: LocalizedStringKey.aboutShops)
            detailsView(imageName: "aboutWines", text: LocalizedStringKey.aboutWines)
            detailsView(imageName: "aboutUsers", text: LocalizedStringKey.aboutUsers)
        }
    }

    // MARK: Displaying Items

    private func detailsView(imageName: String, text: LocalizedStringKey) -> some View {
        VStack(alignment: .center, spacing: 3) {
            Image(imageName)

            Text(text)
                .multilineTextAlignment(.center)
                .frame(height: 48)
                .font(.callout)
        }
    }
}

// MARK: - Preview

#if DEBUG
struct RecommendationsBottomView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationsBottomView()
            .background(Color.red)
    }
}
#endif
