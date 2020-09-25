//
//  CatalogRowView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

struct CatalogRowView: View {
    
    // MARK: - Private Properties
    
    private let item: CatalogItemModel

    // MARK: - Lifecycle
    
    init(item: CatalogItemModel) {
        self.item = item
    }
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color.init(.systemGray4)
            HStack {
                CatalogRowPreviewImageView(item: item)
                    .frame(
                        width: 146,
                        height: 138,
                        alignment: .center
                    )
                    .padding(.leading, 6)
                
                CatalogRowInfoView(item: item)
                    .frame(alignment: .center)
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                    .padding(.leading, 11)
                    .padding(.trailing, 10)
            }
        }
    }
    
}

#if DEBUG
struct CatalogRowViewPreviews: PreviewProvider {
    static var previews: some View {
        let item = CatalogItemModel(title: "Вино для хуесосов")
        return CatalogRowView(item: item)
            .previewLayout(.fixed(width: 414, height: 150))
    }
}
#endif
