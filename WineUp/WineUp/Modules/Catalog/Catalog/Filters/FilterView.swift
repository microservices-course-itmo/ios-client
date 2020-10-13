//
//  FilterView.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 11.10.2020.
//

import SwiftUI

protocol IFilterView {
    var title: String { get }
    var isResetButtonShown: Bool { get }
    var content: AnyView { get }
}

extension IFilterView {
    var isResetButtonShown: Bool { false }
}

struct FilterView: IFilterView {
    var title: String { filterView.title }
    var content: AnyView { filterView.content }
    var isResetButtonShown: Bool { filterView.isResetButtonShown }

    private var filterView: IFilterView

    init(_ filterView: IFilterView) {
        self.filterView = filterView
    }
}
