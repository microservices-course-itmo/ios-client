//
//  CatalogRootView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

struct CatalogRootView: View {
    @EnvironmentObject var popupPresenter: PopupPresenter
    @ObservedObject private var viewModel = CatalogRootViewModel()

    var body: some View {
        NavigationView {
            CatalogView(searchText: "", popupPresenter: popupPresenter)
        }
    }
}
