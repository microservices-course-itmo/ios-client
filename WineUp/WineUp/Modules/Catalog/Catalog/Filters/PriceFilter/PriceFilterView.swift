//
//  PriceFilterView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

struct PriceFilterView: View {

    // MARK: - State
    
    @State private var fromPrice: String = ""
    @State private var toPrice: String = ""
    @State private var toggleSwitch = false
    var items: [PriceFilterItemModel]
    var onItemTap: OnItemTap?

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            HStack(alignment: .center, spacing: 15, content: {
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("От").foregroundColor(.gray)
                    TextField("0000", text: $fromPrice)
                    Divider()
                })

                VStack(alignment: .leading, spacing: 10, content: {
                    Text("До").foregroundColor(.gray)
                    TextField("0000", text: $toPrice)
                    Divider()
                })
            })

            Toggle(isOn: $toggleSwitch) {
                Text("Товар со скидкой")
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0.0) {
                    ForEach(items) { item in
                        PriceFilterItemButton(item: item, action: { self.itemDidTap(item) })
                            .frame(minWidth: 60, maxWidth: .infinity)
                    }
                }
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
        }).padding(.leading, 5)
        .padding(.trailing, 10)
    }

    // MARK: - Actions

    typealias OnItemTap = (PriceFilterItemModel) -> Void

    private func itemDidTap(_ item: PriceFilterItemModel) {
        onItemTap?(item)
    }
}

#if DEBUG

struct PriceFilterViewPreviews: PreviewProvider {
    private static let items = [
        PriceFilterItemModel(title: "До 1500"),
        PriceFilterItemModel(title: "1500-3000"),
        PriceFilterItemModel(title: "3000-5000"),
        PriceFilterItemModel(title: "5000-10000"),
        PriceFilterItemModel(title: "Больше 1000")
    ]
    static var previews: some View {
        return PriceFilterView(items: items, onItemTap: nil)
            .previewLayout(.fixed(width: 414, height: 250))
    }
}

#endif
