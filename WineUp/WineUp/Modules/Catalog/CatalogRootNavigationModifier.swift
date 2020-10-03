//
//  CatalogRootNavigationModifier.swift
//  WineUp
//
//  Created by Александр Пахомов on 03.10.2020.
//

import SwiftUI

struct CatalogRootNavigationModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarHidden(false)
            .navigationBarTitleDisplayMode(.inline)
    }
}
