//
//  CatalogView.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.09.2020.
//

import SwiftUI

struct CatalogView: View {
    @ObservedObject private var viewModel: ViewModel

    init(searchText: String, popupPresenter: PopupPresenter) {
        self.viewModel = ViewModel(searchText: searchText,
                                   popupPresenter: popupPresenter)
    }

    var body: some View {
        VStack(spacing: 0.0) {
            SearchBarView(text: $viewModel.searchText)
            Text(viewModel.searchText)
            CatalogFiltersBarView(items: viewModel.filtersBarItems) { item in
                self.viewModel.filterItemDidTap(item)
            }
            List(viewModel.items) { item in
                CatalogRowView(item: item)
            }
        }
        .navigationBarHidden(false)
        .navigationTitle("Catalog")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
struct CatalogView_Previews: PreviewProvider {

    static var previews: some View {
        CatalogView(searchText: "", popupPresenter: PopupPresenter())
            .previewDevice("iPhone 11 Pro")
    }
}
#endif
