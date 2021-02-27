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
    @State private var showLogoutActionSheet = false

    var body: some View {
        VStack {
            Spacer()

            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 240)

            Spacer()

            if let user = viewModel.user {
                userInfoView(user: user)
            } else {
                Text("").onAppear(perform: viewModel.logoutButtonDidTap)
            }
        }
    }

    private func userInfoView(user: UserJson) -> some View {
        VStack(spacing: 0) {
            Text(user.name)
                .font(.title)
                .padding()

            VStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Номер телефона:")
                        .foregroundColor(.gray)

                    Text(user.phoneNumber)
                        .frame(width: 260)
                        .padding(.vertical, 14)
                        .background(Color(.systemGray6))
                        .cornerRadius(8.0)
                }
                .padding(.bottom)

                VStack(alignment: .leading) {
                    Text("Город:")
                        .foregroundColor(.gray)

                    Text(user.city.titleName)
                        .frame(width: 260)
                        .padding(.vertical, 14)
                        .background(Color(.systemGray6))
                        .cornerRadius(8.0)

                }
                .padding(.bottom, 32)

                Button(action: { showLogoutActionSheet = true }, label: {
                    Text("Выйти из аккаунта")
                })
                .defaultStyled(isDisabled: false)
                .padding(.bottom, 16)
                .actionSheet(isPresented: $showLogoutActionSheet, content: {
                    ActionSheet(title: Text("Вы уверены?"),
                                message: Text("Потом придётся снова авторизовываться"),
                                buttons: [
                                    .destructive(Text("Выйти")) { self.viewModel.logoutButtonDidTap() },
                                    .cancel()
                                ])
                })

                showAPNsButton
            }
            .padding()
        }
        .cardStyled()
        .frame(maxHeight: 450)
        .padding()
    }

    private var showAPNsButton: some View {
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

// MARK: - Preview

#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: .preview)
    }
}
#endif
