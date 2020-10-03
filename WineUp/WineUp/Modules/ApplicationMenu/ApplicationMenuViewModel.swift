//
//  ApplicationMenuViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation

extension ApplicationMenuView {
    class ViewModel: ObservableObject {
        var catalogRootViewModel: CatalogRootView.ViewModel {
            return .init()
        }
    }
}
