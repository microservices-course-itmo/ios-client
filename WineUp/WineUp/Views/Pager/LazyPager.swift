//
//  LazyPager.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI

struct LazyPager<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: (Int) -> Content

    init(pageCount: Int, currentIndex: Binding<Int>, content: @escaping (Int) -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            LazyHStack(spacing: 0) {
                ForEach(0..<pageCount, id: \.self) {
                    content($0)
                        .frame(width: geometry.size.width)
                }
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(currentIndex) * geometry.size.width)
        }
    }
}
