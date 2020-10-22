//
//  LoginBirthdayInput.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import SwiftUI

// MARK: - View

struct LoginBirthdayInput: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        LoginOneButtonContainer(
            title: "Укажите вашу дату рождения",
            isButtonActive: viewModel.isDoneButtonActive,
            buttonTitle: "Далее",
            onButtonTap: viewModel.doneButtonDidTap, label: {
                DatePicker("День рождения", selection: $viewModel.birthday, displayedComponents: .date)
                    .padding()
            }
        )
    }
}

extension LoginBirthdayInput {
    final class ViewModel: ObservableObject {

        @Published var birthday = Date() {
            didSet {
                birthdayDidChange(birthday: birthday)
            }
        }
        @Published var isDoneButtonActive = false

        private let onSubmit: () -> Void

        init(onSubmit: @escaping () -> Void) {
            self.onSubmit = onSubmit
        }

        func doneButtonDidTap() {
            onSubmit()
        }

        private func birthdayDidChange(birthday: Date?) {
            isDoneButtonActive = birthday != nil
        }
    }
}
