//
//  ProfileView.swift
//  WineUp
//
//  Created by Александр Пахомов on 31.10.2020.
//

import SwiftUI

// MARK: - View

struct ProfileView: View {

    @ObservedObject private(set) var viewModel: ViewModel
    @State private var showingAlert = false

    var body: some View {
        VStack(spacing: 32) {
            Button(action: viewModel.logoutButtonDidTap, label: {
                Text("Logout")
            })
            .defaultStyled(isDisabled: false)

            Button(action: {
                self.showingAlert = true
            }, label: {
                Text("Show APNs Token")
            })
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("APNs Token (hex representation)"),
                    message: Text("Hex representation: \(viewModel.hexAPNSId ?? "#error")"),
                    primaryButton: .default(Text("Copy to clipboard"), action: {
                        UIPasteboard.general.string = viewModel.hexAPNSId
                    }),
                    secondaryButton: .default(Text("OK"))
                )
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: .preview)
    }
}
#endif
