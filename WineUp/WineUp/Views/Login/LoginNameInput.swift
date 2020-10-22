//
//  LoginNameInput.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import SwiftUI

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
                    .font(.system(size: 16))
            }
        )
    }
}

extension LoginNameInput {
    final class ViewModel: ObservableObject {

        @Published var name: FormattableContainer<String>!
        @Published var isDoneButtonActive = false

        private let onSubmit: () -> Void

        init(onSubmit: @escaping () -> Void) {
            self.onSubmit = onSubmit
            self.name = .init("", formatter: self.format(_:), onChange: self.nameDidChange(name:))
        }

        func doneButtonDidTap() {
            onSubmit()
        }

        private func format(_ rawName: String) -> String {
            return rawName
        }

        private func nameDidChange(name: String) {
            isDoneButtonActive = !name.isEmpty
        }
    }
}
