//
//  LoginCityInput.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import SwiftUI

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
                    .font(.system(size: 16))
            }
        )
    }
}

extension LoginCityInput {
    final class ViewModel: ObservableObject {

        @Published var city: FormattableContainer<String>!
        @Published var isDoneButtonActive = false

        private let onSubmit: () -> Void

        init(onSubmit: @escaping () -> Void) {
            self.onSubmit = onSubmit
            self.city = .init("", formatter: self.format(_:), onChange: self.cityDidChange(city:))
        }

        func doneButtonDidTap() {
            onSubmit()
        }

        private func format(_ rawCity: String) -> String {
            return rawCity
        }

        private func cityDidChange(city: String) {
            isDoneButtonActive = !city.isEmpty
        }
    }
}
