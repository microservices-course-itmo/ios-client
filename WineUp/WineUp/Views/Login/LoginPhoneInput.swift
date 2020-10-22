//
//  LoginPhoneInput.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI
import Combine

// MARK: - View

struct LoginPhoneInput: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        print("Render, phoneNumber: \(viewModel.phoneNumber)")

        return LoginOneButtonContainer(
            title: "Введите ваш номер телефона",
            isButtonActive: viewModel.isNextButtonActive,
            buttonTitle: "Далее",
            onButtonTap: viewModel.loginButtonDidTap,
            label: {
                TextField("+7 (XXX) XXX-XX-XX", text: $viewModel.phoneNumber.value)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
                    .keyboardType(.phonePad)
            }
        )
    }
}

// MARK: - ViewModel

extension LoginPhoneInput {
    final class ViewModel: ObservableObject {

        @Published var isNextButtonActive = false
        @Published var phoneNumber = FormattableContainer("", formatter: ViewModel.formatRuPhoneNumber(phone:)) {
            didSet {
                phoneNumberDidSet()
            }
        }

        let onNextButtonTap: () -> Void

        init(onNextButtonTap: @escaping () -> Void) {
            self.onNextButtonTap = onNextButtonTap
        }

        // MARK: - Public Methods

        func loginButtonDidTap() {
            onNextButtonTap()
        }

        func continueWithoutAuthButtonDidTap() {

        }

        // MARK: - Private Methods

        private func phoneNumberDidSet() {
            isNextButtonActive = phoneNumber.value.count == 18
        }

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

//struct LoginPhoneInput_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginPhoneInput()
//    }
//}
