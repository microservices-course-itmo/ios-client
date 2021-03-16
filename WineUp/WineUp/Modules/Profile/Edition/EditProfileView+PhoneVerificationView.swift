//
//  EditProfileView+PhoneVerificationView.swift
//  WineUp
//
//  Created by Александр Пахомов on 14.03.2021.
//

import SwiftUI

// MARK: - View

extension EditProfileView {
    struct PhoneVerificationView: View {

        @ObservedObject var viewModel: ViewModel
        @State private var verificationCode = ""

        var body: some View {
            VStack {
                Spacer()

                Text("Введите код верификации")
                    .font(.title)
                    .padding()

                TextField("000000", text: $verificationCode.onSet(codeDidSet(_:)))
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                Button(action: viewModel.cancelPhoneVerification) {
                    Text("Отменить")
                        .padding()
                }
                .padding(.bottom)
            }
            .activity(triggers: viewModel.updatingPhoneNumberSuccess)
        }

        private func codeDidSet(_ code: String) {
            guard code.count == 6 else { return }
            viewModel.submitVerificationCode(code)
        }
    }
}

// MARK: - Preview

#if DEBUG
struct EditProfilePhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView.PhoneVerificationView(viewModel: .preview)
    }
}
#endif
