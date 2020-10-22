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

    var body: some View {
        LoginOneButtonContainer(
            title: "Укажите ваше имя",
            isButtonActive: viewModel.isDoneButtonActive,
            buttonTitle: "Далее",
            onButtonTap: viewModel.doneButtonDidTap, label: {
                TextField("Иван", text: $viewModel.name.value)
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

        @Published var name: FormattableContainer<String>!
        @Published var isDoneButtonActive = false

        private let onSubmit: () -> Void

        // MARK: Public Methods

        init(onSubmit: @escaping () -> Void) {
            self.onSubmit = onSubmit
            self.name = .init("", formatter: self.format(_:), onChange: self.nameDidChange(name:))
        }

        func doneButtonDidTap() {
            onSubmit()
        }

        // MARK: Private Methods

        private func format(_ rawName: String) -> String {
            return rawName
        }

        private func nameDidChange(name: String) {
            isDoneButtonActive = !name.isEmpty
        }
    }
}

// MARK: - Preview

#if DEBUG
struct LoginNameInput_Previews: PreviewProvider {
    static var previews: some View {
        LoginNameInput(viewModel: .init(onSubmit: {}))
    }
}
#endif
