//
//  ApplicationRootView.swift
//  WineUp
//
//  Created by Александр Пахомов on 22.09.2020.
//

import SwiftUI

// MARK: - View

struct ApplicationRootView: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        ApplicationMenuView(viewModel: viewModel.applicationMenuViewModel)
    }
}

// MARK: - Preview

#if DEBUG
struct ApplicationRootView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationRootView(viewModel: .init())
    }
}
#endif
