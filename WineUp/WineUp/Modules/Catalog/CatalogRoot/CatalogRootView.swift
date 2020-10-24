//
//  CatalogRootView.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import SwiftUI

// MARK: - View

/// Navigation wrapper of CatalogView
struct CatalogRootView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        NavigationView {
            CatalogView(viewModel: viewModel.catalogViewModel)
        }
    }
}

// MARK: - Preview

#if DEBUG
struct CatalogRootView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogRootView(viewModel: .init())
    }
}
#endif
