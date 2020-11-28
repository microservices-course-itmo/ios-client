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
        switch viewModel.didLogin {
        case .notRequested:
            Text("").onAppear(perform: viewModel.appDidLoad)
        case let .loaded(didLogin):
            if !didLogin {
                LoginView(viewModel: viewModel.loginViewModel)
            } else {
                ApplicationMenuView(viewModel: viewModel.applicationMenuViewModel)
            }
        case let .failed(error):
            Text(error.localizedDescription)
        case .isLoading:
            EmptyView()
        }
    }
}

// MARK: - Preview

#if DEBUG
struct ApplicationRootView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationRootView(viewModel: .preview)
    }
}
#endif
