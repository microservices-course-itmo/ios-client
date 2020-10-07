//
//  CharacteristicsFilterItemView.swift
//  WineUp
//
//  Created by Влад on 05.10.2020.
//

import SwiftUI

struct CharacteristicsFilterItemModel: Identifiable {
    var id = UUID()
    var title: String
}

struct CharacteristicsFilterItemView: View {
    let item: CharacteristicsFilterItemModel
    var isChecked: Bool
    let chColor = Color(red: 158 / 255.0, green: 51 / 255.0, blue: 75 / 255.0)
    var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .center) {
                Image(systemName: isChecked ? "checkmark.square.fill": "square").foregroundColor(isChecked ? chColor : .black)
                Text(item.title).foregroundColor(.primary).font(.system(size: 13))
            }
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
struct CharacteristicsFilterItemViewPreview: PreviewProvider {
    private static let item = CharacteristicsFilterItemModel(title: "Test")
    static var previews: some View {
        return CharacteristicsFilterItemView(item: item, isChecked: false)
            .previewLayout(.fixed(width: 400, height: 250))
    }
}
#endif
