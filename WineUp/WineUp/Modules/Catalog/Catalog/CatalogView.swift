//
//  CatalogView.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.09.2020.
//

import SwiftUI

struct CatalogView: View {
    @ObservedObject private var viewModel = CatalogViewModel()

    init(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            CatalogFilterView()
            List(viewModel.items) { item in
                CatalogRowView(item: item)
            }
        }
    }
}
