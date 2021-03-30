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
        loginView
            .overlay(
                Color.clear
                    .frame(width: 0, height: 0)
                    .fullScreenCover(isPresented: $viewModel.showError503Screen, content: {
                        Error503Screen()
                    })
            )
    }

    @ViewBuilder var loginView: some View {
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
