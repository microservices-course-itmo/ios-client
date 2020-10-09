//
//  CharacteristicsFilterItemButton.swift
//  WineUp
//
//  Created by Влад on 05.10.2020.
//

import SwiftUI

struct CharacteristicsFilterItemButton: View {
    let item: CharacteristicsFilterItemModel
    @State var isChecked: Bool = false
    func action () {
        isChecked.toggle()
    }
    var body: some View {
        Button(action: action, label: {
            CharacteristicsFilterItemView(item: item, isChecked: isChecked).padding(.leading)
        })
    }
}
