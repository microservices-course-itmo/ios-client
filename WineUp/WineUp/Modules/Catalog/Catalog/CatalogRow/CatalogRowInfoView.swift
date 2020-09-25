//
//  CatalogRowInfoView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

struct CatalogRowInfoView: View {
    
    // MARK: - Private Properties
    
    let item: CatalogItemModel

    // MARK: - Lifecycle
    
    init(item: CatalogItemModel) {
        self.item = item
    }
    
    // MAR: - View
    
    var body: some View {
        VStack {
            HStack {
                Text(item.title)
                    .font(.system(size: 20))
                    .fontWeight(.black)
                    .lineLimit(2)
                
                Spacer()
                
                Image(systemName: "suit.heart.fill")
                    .foregroundColor(getHeartColor())
                    .font(.system(size: 25))
            }
            
            Spacer()
            
            HStack {
                Text(item.wineDescription)
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                // TODO: Add percent to CatalogItemModel
                
                Text("Подходит вам на 75%")
                    .font(.system(size: 11))
            }
            
            Spacer()
            
            HStack {
                Image(uiImage: item.retailerImage)
                    .frame(height: 40)
                
                Spacer()
                CatalogRowDiscountView(item: item)
            }
        }
    }
}

// MARK: - View Methods

extension CatalogRowInfoView {
    
    func getHeartColor() -> Color {
        return item.isLiked ? .black : .white
    }
    
}

// MARK: - Preview Settings

#if DEBUG
struct CatalogRowInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogRowInfoView(item: CatalogItemModel(title: "ASD"))
            .previewLayout(.fixed(width: 274, height: 130))
    }
}
#endif
