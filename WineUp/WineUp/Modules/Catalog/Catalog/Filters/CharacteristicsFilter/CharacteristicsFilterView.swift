//
//  CharacteristicsFilterView.swift
//  WineUp
//
//  Created by Влад on 05.10.2020.
//

import SwiftUI

struct CharacteristicsFilterView: View {
    var items: [CharacteristicsFilterItemModel]
    var body: some View {
        VStack(alignment: .trailing, spacing: 15) {
            ForEach(items) {  item in
                CharacteristicsFilterItemButton(item: item)
                    .frame(minWidth: 60, maxWidth: .infinity)
                Divider()
            }
        }
    }
}

#if DEBUG
struct CharacteristicsFilterViewPreviews: PreviewProvider {
    private static let ColorItems = [
        CharacteristicsFilterItemModel(title: "Белое"),
        CharacteristicsFilterItemModel(title: "Красное"),
        CharacteristicsFilterItemModel(title: "Розовое")
    ]
    private static let SugarItems = [
        CharacteristicsFilterItemModel(title: "Сладкое"),
        CharacteristicsFilterItemModel(title: "Полусладкое"),
        CharacteristicsFilterItemModel(title: "Полусухое"),
        CharacteristicsFilterItemModel(title: "Сухое")
    ]
    static var previews: some View {
        Group {
            CharacteristicsFilterView(items: ColorItems)
                .previewLayout(.fixed(width: 400, height: 250))
            CharacteristicsFilterView(items: SugarItems)
                .previewLayout(.fixed(width: 400, height: 250))
        }
    }
}
#endif
