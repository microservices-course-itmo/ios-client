
//
//  PriceFilterItems.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

struct PriceFilterItemModel: Identifiable {
    var id = UUID()
    var title: String
}

struct PriceFilterItemView: View {
    
    // MARK: - State
    
    let item: PriceFilterItemModel
    
    // MARK: - View
    
    var body: some View {
        Text(item.title)
            .foregroundColor(.primary)
            .font(.system(size: 13))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray, lineWidth: 1)
                    .padding([.leading, .trailing], -10)
                    .padding([.top, .bottom], -10)
            )
    }
    
}
