//
//  PriceFilterItemButton.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

struct PriceFilterItemButton: View {
    let item: PriceFilterItemModel
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            PriceFilterItemView(item: item).padding()
        })
    }
}
