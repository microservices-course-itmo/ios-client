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
            Spacer()
//            Spacer()

            VStack(spacing: 0) {
                Text("Иван Иванов")
                    .font(.title)
                    .padding()

                VStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Номер телефона:")
                            .foregroundColor(.gray)

                        Text("+7 (911) 272-78-57")
                            .frame(width: 260)
                            .padding(.vertical, 16)
                            .background(Color(.systemGray6))
                            .cornerRadius(8.0)
                    }
                    .padding(.bottom)

                    VStack(alignment: .leading) {
                        Text("Город:")
                            .foregroundColor(.gray)

                        Text("Москва")
                            .frame(width: 260)
                            .padding(.vertical, 16)
                            .background(Color(.systemGray6))
                            .cornerRadius(8.0)

                    }
                    .padding(.bottom, 48)

                    Button(action: viewModel.logoutButtonDidTap, label: {
                        Text("Выйти из аккаунта")
                    })
                    .defaultStyled(isDisabled: false)
                    .padding(.bottom, 32)

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
                .padding()
            }
            .cardStyled()
            .frame(maxHeight: 600)
            .padding()


            //
            //
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
