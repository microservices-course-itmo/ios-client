//
//  LoginPhoneInput.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI
import Combine
import Firebase

// MARK: - Constants

private extension Font {
    static let phoneNumberTextField: Font = .system(size: 16)
}

// MARK: - View

struct LoginPhoneInput: View {

    @ObservedObject private(set) var viewModel: ViewModel

    let onSubmit: () -> Void

    var body: some View {
        LoginOneButtonContainer(
            title: "Введите ваш номер телефона",
            isButtonActive: viewModel.isNextButtonActive,
            buttonTitle: "Далее",
            onButtonTap: {
                viewModel.nextButtonDidTap(onSubmit: onSubmit)
            },
            label: {
                TextField("+7 (XXX) XXX-XX-XX", text: $viewModel.phoneNumber.value)
                    .multilineTextAlignment(.center)
                    .font(.phoneNumberTextField)
                    .keyboardType(.phonePad)
            }
        )
        .activity(hasActivity: viewModel.hasActivity)
    }
}

// MARK: - LoginPhoneInput+ViewModel

extension LoginPhoneInput {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var hasActivity = false
        @Published var isNextButtonActive = false
        @Published var phoneNumber = FormattableContainer("", formatter: ViewModel.formatRuPhoneNumber(phone:))

        private let container: DIContainer
        private let cancelBag = CancelBag()

        // MARK: Public Methods

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.bindDisplayValue(\.userData.loginForm.phoneNumber, to: self, by: \.phoneNumber.value)
                $phoneNumber.map(\.value).toInputtable(of: container.appState, at: \.value.userData.loginForm.phoneNumber)
                container.appState
                    .map { $0.userData.loginForm.phoneNumber.value?.count == 18 }
                    .bind(to: self, by: \.isNextButtonActive)
            }
        }

        func continueWithoutAuthButtonDidTap() {

        }

        func nextButtonDidTap(onSubmit: @escaping () -> Void) {
            guard let phoneNumber = container.appState.value.userData.loginForm.phoneNumber.value else {
                return
            }

            assert(!hasActivity)
            hasActivity = true

            container.services.firebaseService
                .sendVerificationCode(to: phoneNumber)
                .sinkToResult { [weak self] result in
                    switch result {
                    case .success(let verificationID):
                        self?.container.appState.value.userData.loginForm.verificationId = verificationID
                        self?.hasActivity = false
                        onSubmit()
                    case .failure(let error):
                        print("verifyError: ", error.description)
                    }
                }
                .store(in: cancelBag)
        }

        // MARK: Private Methods

        private static func formatRuPhoneNumber(phone: String) -> String {
            return format(mask: "+X (XXX) XXX-XX-XX", phone: phone)
        }

        /// Formats `phone` value using `mask` where 'X' means a space which must be replaces with a digit
        private static func format(mask: String, phone: String) -> String {
            var numbers = phone.onlyDigits
            var result = ""
            var index = numbers.startIndex

            // Insert '7' at first position if needed
            if numbers.first != "7" && !numbers.isEmpty {
                if numbers.first == "8" {
                    numbers.remove(at: numbers.index(numbers.startIndex, offsetBy: 0))
                }
                numbers.insert("7", at: numbers.index(numbers.startIndex, offsetBy: 0))
            }

            for char in mask where index < numbers.endIndex {
                if char == "X" {
                    result.append(numbers[index])
                    index = numbers.index(after: index)
                } else {
                    result.append(char)
                }
            }
            return result
        }
    }
}

// MARK: - Preview

#if DEBUG
extension LoginPhoneInput.ViewModel {
    static let preview = LoginPhoneInput.ViewModel(container: .preview)
}

struct LoginPhoneInput_Previews: PreviewProvider {
    static var previews: some View {
        LoginPhoneInput(viewModel: .preview, onSubmit: {})
    }
}
#endif
