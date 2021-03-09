//
//  LoginNameInput.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension Font {
    static let nameTextField: Font = .system(size: 16)
}

// MARK: - View

struct LoginNameInput: View {

    @ObservedObject private(set) var viewModel: ViewModel
    let onSubmit: () -> Void

    var body: some View {
        LoginOneButtonContainer(
            title: "Укажите ваше имя",
            isButtonActive: viewModel.isDoneButtonActive,
            buttonTitle: "Далее",
            onButtonTap: onSubmit, label: {
                TextField("Иван", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .font(.nameTextField)
            }
        )
    }
}

// MARK: - LoginNameInput+ViewModel

extension LoginNameInput {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var name = ""
        @Published var isDoneButtonActive = false

        private let container: DIContainer
        private let cancelBag = CancelBag()

        // MARK: Public Methods

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.bindDisplayValue(\.userData.loginForm.name, to: self, by: \.name)
                $name.toInputtable(of: container.appState, at: \.value.userData.loginForm.name)

                container.appState
                    .map { ViewModel.validate(name: $0.userData.loginForm.name) }
                    .bind(to: self, by: \.isDoneButtonActive)
            }
        }

        // MARK: - Helpers

        private static func validate(name: Inputtable<String>) -> Bool {
            guard let value = name.value else { return false }
            return validate(name: value)
        }

        private static func validate(name: String) -> Bool {
            let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
            let regexPattern = "^[\\p{L}\\h\\.]{0,30}$"
            let matches = NSPredicate(format: "SELF MATCHES %@", regexPattern).evaluate(with: name)

            return matches
        }
    }
}

// MARK: - Preview

#if DEBUG
extension LoginNameInput.ViewModel {
    static let preview = LoginNameInput.ViewModel(container: .preview)
}

struct LoginNameInput_Previews: PreviewProvider {
    static var previews: some View {
        LoginNameInput(viewModel: .preview, onSubmit: {})
    }
}
#endif
