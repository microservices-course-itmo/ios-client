//
//  LoginPhoneInput.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI
import Combine

// MARK: - Constants

private extension Font {
    static let phoneNumberTextField: Font = .system(size: 16)
}

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
                    .font(.phoneNumberTextField)
                    .keyboardType(.phonePad)
            }
        )
    }
}

// MARK: - LoginPhoneInput+ViewModel

extension LoginPhoneInput {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var isNextButtonActive = false
        @Published var phoneNumber = FormattableContainer("", formatter: ViewModel.formatRuPhoneNumber(phone:)) {
            didSet {
                phoneNumberDidSet()
            }
        }

        let onNextButtonTap: () -> Void

        // MARK: Public Methods

        init(onNextButtonTap: @escaping () -> Void) {
            self.onNextButtonTap = onNextButtonTap
        }

        func loginButtonDidTap() {
            onNextButtonTap()
        }

        func continueWithoutAuthButtonDidTap() {

        }

        // MARK: Private Methods

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

// MARK: - Preview

#if DEBUG
struct LoginPhoneInput_Previews: PreviewProvider {
    static var previews: some View {
        LoginPhoneInput(viewModel: .init(onNextButtonTap: {}))
    }
}
#endif
