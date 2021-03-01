//
//  EditProfileView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 28.02.2021.
//

import SwiftUI

// MARK: - View

struct EditProfileView: View {

    @StateObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            Text("Редактирование")
                .font(.title)
                .padding()

            VStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Номер телефона:")
                        .foregroundColor(.gray)

                    TextField("+7 (XXX) XXX-XX-XX", text: $viewModel.phoneNumber.value)
                        .frame(width: 260)
                        .padding(.vertical, 14)
                        .background(Color(.systemGray6))
                        .cornerRadius(8.0)
                        .multilineTextAlignment(.center)

                }
                .padding(.bottom)

                VStack(alignment: .leading) {
                    Text("Город:")
                        .foregroundColor(.gray)
                        .padding(.leading, 32)

                    Picker("", selection: $viewModel.city) {
                        ForEach(City.displayCases) { city in
                            Text(city.titleName)
                                .tag(city)
                        }
                    }
                }
                .padding(.bottom, 32)

                Button(action: {
                    viewModel.updateProfile()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cохранить")
                })
                .defaultStyled(isDisabled: false)
                .padding(.bottom, 16)
            }
            .padding()
        }
        .cardStyled()
        .frame(maxHeight: 450)
        .padding()
    }
}

// MARK: - Preview

#if DEBUG
struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(viewModel: .preview)
    }
}
#endif
