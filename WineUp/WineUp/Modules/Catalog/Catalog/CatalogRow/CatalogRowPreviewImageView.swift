//
//  CatalogRowPreviewImageView.swift
//  WineUp
//
//  Created by George on 25.09.2020.
//

import SwiftUI

struct CatalogRowPreviewImageView: View {
    
    // MARK: - Private Properties
    
    let item: CatalogItemModel

    // MARK: - Lifecycle
    
    init(item: CatalogItemModel) {
        self.item = item
    }
    
    // MAR: - View
    
    var body: some View {
        ZStack {
            Color.init(.white)
            Image(uiImage: item.titleImage)
            CatalogRowRating(item: item)
        }
    }
}

// MARK: - Preview Setttings

#if DEBUG
struct CatalogRowPreviewImageView_Previews: PreviewProvider {
    static var previews: some View {
        return CatalogRowPreviewImageView(item: CatalogItemModel(title: "ASD"))
            .previewLayout(.fixed(width: 130, height: 130))
    }
}
#endif
