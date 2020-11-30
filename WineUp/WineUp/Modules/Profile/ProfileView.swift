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
        VStack {

            Button(action: viewModel.logoutButtonDidTap, label: {
                Text("Logout")
            })
            .defaultStyled(isDisabled: false)
            Button(action: {
                self.showingAlert = true
            })
            {
                Text("Show APNS ID")
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("APNS"), message: Text(UserDefaults.standard.string(forKey: "APNSID") ?? "error"), dismissButton: .default(Text("OK")))
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
