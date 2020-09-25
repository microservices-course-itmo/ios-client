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
        VStack {
            Color.init(.clear)
            Text("Оценка экспертов:")
                .font(.system(size: 11))
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Spacer()
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(self.getColorFor(index: 1))
                Image(systemName: "star.fill")
                    .foregroundColor(self.getColorFor(index: 2))
                Image(systemName: "star.fill")
                    .foregroundColor(self.getColorFor(index: 3))
                Image(systemName: "star.fill")
                    .foregroundColor(self.getColorFor(index: 4))
                Image(systemName: "star.fill")
                    .foregroundColor(self.getColorFor(index: 5))
            }
            .padding(.bottom, 10)
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
