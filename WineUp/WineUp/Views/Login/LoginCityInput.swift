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

    var body: some View {
        LoginOneButtonContainer(
            title: "Укажите ваш город",
            isButtonActive: viewModel.isDoneButtonActive,
            buttonTitle: "Далее",
            onButtonTap: viewModel.doneButtonDidTap, label: {
                TextField("Москва", text: $viewModel.city.value)
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

        @Published var city: FormattableContainer<String>!
        @Published var isDoneButtonActive = false

        private let onSubmit: () -> Void

        // MARK: Public Methods

        init(onSubmit: @escaping () -> Void) {
            self.onSubmit = onSubmit
            self.city = .init("", formatter: self.format(_:), onChange: self.cityDidChange(city:))
        }

        func doneButtonDidTap() {
            onSubmit()
        }

        // MARK: Private Methods

        private func format(_ rawCity: String) -> String {
            return rawCity
        }

        private func cityDidChange(city: String) {
            isDoneButtonActive = !city.isEmpty
        }
    }
}

// MARK: - Preview

#if DEBUG
struct LoginCityInput_Previews: PreviewProvider {
    static var previews: some View {
        LoginCityInput(viewModel: .init(onSubmit: {}))
    }
}
#endif
