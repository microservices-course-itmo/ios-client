//
//  LoginCityInput.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension Font {
    static let cityTextField: Font = .system(size: 16)
}

// MARK: - View

struct LoginCityInput: View {

    @ObservedObject private(set) var viewModel: ViewModel
    let onSubmit: () -> Void

    var body: some View {
        LoginOneButtonContainer(
            title: "Укажите ваш город",
            isButtonActive: viewModel.isDoneButtonActive,
            buttonTitle: "Далее",
            onButtonTap: onSubmit, label: {
                TextField("Москва", text: $viewModel.city)
                    .multilineTextAlignment(.center)
                    .font(.cityTextField)
            }
        )
    }
}

// MARK: - LoginCityInput+ViewModel

extension LoginCityInput {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var city = ""
        @Published var isDoneButtonActive = false

        private let container: DIContainer
        private let cancelBag = CancelBag()

        // MARK: Public Methods

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.bindDisplayValue(\.userData.loginForm.city, to: self, by: \.city)
                $city.toInputtable(of: container.appState, at: \.value.userData.loginForm.city)
                container.appState.map { $0.userData.loginForm.city.hasValue }.bind(to: self, by: \.isDoneButtonActive)
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
extension LoginCityInput.ViewModel {
    static let preview = LoginCityInput.ViewModel(container: .preview)
}

struct LoginCityInput_Previews: PreviewProvider {
    static var previews: some View {
        LoginCityInput(viewModel: .preview, onSubmit: {})
    }
}
#endif
