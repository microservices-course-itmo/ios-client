//
//  ApplicationRootView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 22.09.2020.
//

import Foundation

extension ApplicationRootView {
    class ViewModel: ObservableObject {
        var applicationMenuViewModel: ApplicationMenuView.ViewModel {
            return .init()
        }
    }
}
