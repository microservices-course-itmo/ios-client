//
//  ApplicationRootView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 22.09.2020.
//

import Foundation

// MARK: - Variables & Init

extension ApplicationRootView {
    final class ViewModel: ObservableObject {

    }
}

// MARK: - Public Methods

extension ApplicationRootView.ViewModel {
    var applicationMenuViewModel: ApplicationMenuView.ViewModel {
        return .init()
    }
}
