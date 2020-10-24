//
//  ApplicationRootView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 22.09.2020.
//

import Foundation

// MARK: - ApplicationRootView+ViewModel

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
