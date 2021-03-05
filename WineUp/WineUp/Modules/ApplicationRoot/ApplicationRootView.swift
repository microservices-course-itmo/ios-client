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
        if let didLogin = viewModel.didLogin {
            if !didLogin {
                LoginView(viewModel: viewModel.loginViewModel)
            } else {
                ApplicationMenuView(viewModel: viewModel.applicationMenuViewModel)
            }
        } else {
            Color.clear
                .onAppear(perform: viewModel.appDidLoad)
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
