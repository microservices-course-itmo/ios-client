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

    let onNextButtonTap: () -> Void

    var body: some View {
        LoginOneButtonContainer(
            title: "Введите ваш номер телефона",
            isButtonActive: viewModel.isNextButtonActive,
            buttonTitle: "Далее",
            onButtonTap: onNextButtonTap,
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
        @Published var phoneNumber = FormattableContainer("", formatter: ViewModel.formatRuPhoneNumber(phone:))

        private let container: DIContainer
        private let cancelBag = CancelBag()

        // MARK: Public Methods

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.bindDisplayValue(\.userData.loginForm.phoneNumber, to: self, by: \.phoneNumber.value)
                $phoneNumber.map(\.value).toInputtable(of: container.appState, at: \.value.userData.loginForm.phoneNumber)
                container.appState.map { $0.userData.loginForm.phoneNumber.value?.count == 18 }.bind(to: self, by: \.isNextButtonActive)
            }
        }

        func continueWithoutAuthButtonDidTap() {

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
        LoginPhoneInput(viewModel: .preview, onNextButtonTap: {})
    }
}
#endif
