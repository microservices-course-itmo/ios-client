//
//  LazyPager.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI

// MARK: - View

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

// MARK: - Preview

#if DEBUG
struct LazyPager_Previews: PreviewProvider {
    private static func pageFor(index: Int) -> some View {
        switch index {
        case 0:
            return Color.red
        case 1:
            return Color.blue
        default:
            return Color.clear
        }
    }

    static var previews: some View {

        Group {
            LazyPager(pageCount: 2, currentIndex: .constant(0), content: pageFor(index:))
            LazyPager(pageCount: 2, currentIndex: .constant(1), content: pageFor(index:))
        }
        .previewLayout(.fixed(width: 414, height: 300))
    }
}
#endif
