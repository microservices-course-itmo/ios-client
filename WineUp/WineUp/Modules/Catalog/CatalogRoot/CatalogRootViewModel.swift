//
//  CatalogRootViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation

extension CatalogRootView {
    class ViewModel: ObservableObject {
        var catalogViewModel: CatalogView.ViewModel {
            return .init()
        }
    }
}
