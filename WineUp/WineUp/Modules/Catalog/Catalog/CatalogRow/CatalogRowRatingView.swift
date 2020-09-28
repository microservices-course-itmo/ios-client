//
//  CatalogRowRating.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

struct CatalogRowRating: View {
    
    // MARK: - Private Properties
    
    let item: CatalogItemModel

    // MARK: - Lifecycle
    
    init(item: CatalogItemModel) {
        self.item = item
    }
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color.init(.sRGB, white: 1, opacity: 0.6).ignoresSafeArea()
            VStack {
                Text("Оценка экспертов:")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                Spacer()
                HStack {
                    ForEach(1..<6) { index in
                        Image(systemName: "star.fill")
                            .font(.system(size: 13))
                            .foregroundColor(self.getColorFor(index: Float(index)))
                    }

                }
                .padding(.bottom, 10)
            }
        }
    }
}

// MARK: - View Methods

extension CatalogRowRating {
    
    func getColorFor(index: Float) -> Color {
        return index <= item.rating ? .black : .gray
    }
    
}

// MARK: - Preview Settings

#if DEBUG
struct CatalogRowRating_Previews: PreviewProvider {
    static var previews: some View {
        let item = CatalogItemModel(title: "ASD")
        return CatalogRowRating(item: item)
            .previewLayout(.fixed(width: 120, height: 50))
    }
}
#endif
