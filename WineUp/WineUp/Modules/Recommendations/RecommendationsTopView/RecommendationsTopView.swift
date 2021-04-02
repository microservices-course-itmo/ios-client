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
            content()
        }

    // MARK: Displaying Items

    private func content() -> some View {
            TabView {
                imageView()
                imageView()
                imageView()
                imageView()
                imageView()
            }
            .tabViewStyle(PageTabViewStyle())
    }

    private func imageView() -> some View {
        KFImage.fromUniverseUrl("https://picsum.photos/311/185")
            .cornerRadius(5.0)
            .frame(width: 336, height: 209, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.white)
            .cornerRadius(8)
        }
    }

// MARK: - Preview

#if DEBUG
struct RecommendationsTopView_Previews: PreviewProvider {
    static var previews: some View {
        return RecommendationsTopView()
            .previewLayout(.fixed(width: 414, height: 300))
            .background(Color.red)
    }
}
#endif
