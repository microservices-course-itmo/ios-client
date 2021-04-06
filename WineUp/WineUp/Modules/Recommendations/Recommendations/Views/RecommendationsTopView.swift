//
//  RecommendationsTopView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.04.2021.
//

import SwiftUI
import struct Kingfisher.KFImage

struct RecommendationsTopView: View {
    var body: some View {
        TabView {
            imageView()
            imageView()
            imageView()
            imageView()
            imageView()
        }
        .tabViewStyle(PageTabViewStyle())
        .cornerRadius(5.0)
        .padding(12)
        .background(Color.white)
        .cornerRadius(8)
        .scaledToFit()
    }

    // MARK: Displaying Items

    private func imageView() -> some View {
        KFImage.fromUniverseUrl("https://picsum.photos/311/185")
            .resizable()
            .scaledToFill()
    }
}

// MARK: - Preview

#if DEBUG
struct RecommendationsTopView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationsTopView()
            .previewLayout(.fixed(width: 414, height: 300))
            .padding()
            .background(Color.red)
    }
}
#endif
