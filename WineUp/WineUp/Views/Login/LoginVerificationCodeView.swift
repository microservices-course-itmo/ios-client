//
//  LoginVerificationCodeView.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import SwiftUI

// MARK: - View

struct LoginVerificationCodeView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        LoginContainer(title: "Введите код", viewLabel: {
            TextField("XXXXXX", text: $viewModel.code.value)
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
        }, actionLabel: { () -> AnyView in
            if viewModel.canResendCode {
                return Button(action: viewModel.resendButtonDidTap) {
                    Text("Переотправить")
                }
                .anyView
            } else {
                return Text("Отправить повторно можно через \(viewModel.secondsToResendCode)с").anyView
            }
        })
    }
}

extension LoginVerificationCodeView {
    final class ViewModel: ObservableObject {

        @Published var isCodeWrong = false
        @Published var canResendCode = false
        @Published var secondsToResendCode = 60
        @Published var isResendInProgress = false
        @Published var isSubmitInProgress = false
        @Published var code: FormattableContainer<String>!

        private var timer: Timer!
        private var onSubmit: () -> Void

        init(onSubmit: @escaping () -> Void) {
            self.onSubmit = onSubmit
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                self?.tick()
            }
            self.code = .init("", formatter: ViewModel.format, onChange: self.codeDidChange(code:))
        }

        func resendButtonDidTap() {
            assert(secondsToResendCode == 0 && canResendCode && !isResendInProgress && !isSubmitInProgress)

            isResendInProgress = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isResendInProgress = false
                self.secondsToResendCode = 60
                self.updateUI()
            }
        }

        private func tick() {
            if secondsToResendCode > 0 {
                secondsToResendCode -= 1
                updateUI()
            }
        }

        private func updateUI() {
            canResendCode = secondsToResendCode == 0 && !isResendInProgress && !isSubmitInProgress
        }

        private func codeDidChange(code: String) {
            if code.count == 6 {
                isSubmitInProgress = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isSubmitInProgress = false
                    self.onSubmit()
                }
            }
        }

        private static func format(_ rawValue: String) -> String {
            return rawValue.onlyDigits
        }
    }
}
