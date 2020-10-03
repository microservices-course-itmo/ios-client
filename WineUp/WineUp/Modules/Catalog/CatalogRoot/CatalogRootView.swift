//
//  CatalogRootView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

struct CatalogRootView: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        NavigationView {
            CatalogView(viewModel: viewModel.catalogViewModel)
        }
    }
}
