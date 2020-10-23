//
//  Pager.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI

// MARK: - View

struct Pager<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(currentIndex) * geometry.size.width)
        }
    }
}

// MARK: - Preview

#if DEBUG
struct Pager_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Pager(pageCount: 2, currentIndex: .constant(0)) {
                Color.red
                Color.blue
            }
            Pager(pageCount: 2, currentIndex: .constant(1)) {
                Color.red
                Color.blue
            }
        }
        .previewLayout(.fixed(width: 414, height: 300))
    }
}
#endif
