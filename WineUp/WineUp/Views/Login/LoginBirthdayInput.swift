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
    let onSubmit: () -> Void

    var body: some View {
        LoginOneButtonContainer(
            title: "Укажите вашу дату рождения",
            isButtonActive: viewModel.isDoneButtonActive,
            buttonTitle: "Далее",
            onButtonTap: onSubmit, label: {
                DatePicker("День рождения", selection: $viewModel.birthday, displayedComponents: .date)
                    .padding()
            }
        )
    }
}

// MARK: - LoginBirthdayInput+ViewModel

extension LoginBirthdayInput {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var birthday = Date()
        @Published var isDoneButtonActive = false

        private let container: DIContainer
        private let cancelBag = CancelBag()

        // MARK: Public Methods

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.bindDisplayValue(\.userData.loginForm.birthday, to: self, by: \.birthday)
                $birthday.toInputtable(of: container.appState, at: \.value.userData.loginForm.birthday)
                container.appState.map(\.userData.loginForm.birthday.hadUpdates).bind(to: self, by: \.isDoneButtonActive)
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
extension LoginBirthdayInput.ViewModel {
    static let preview = LoginBirthdayInput.ViewModel(container: .preview)
}

struct LoginBirthdayInput_Previews: PreviewProvider {
    static var previews: some View {
        LoginBirthdayInput(viewModel: .preview, onSubmit: {})
    }
}
#endif
