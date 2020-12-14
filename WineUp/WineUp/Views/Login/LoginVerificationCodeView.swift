//
//  LoginVerificationCodeView.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import SwiftUI
import Combine
import Firebase

// MARK: - View

struct LoginVerificationCodeView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    init(viewModel: ViewModel, onSubmit: @escaping () -> Void) {
        self.viewModel = viewModel
        viewModel.onSubmit = onSubmit
    }

    var body: some View {
        LoginContainer(title: "Введите код", viewLabel: {
            TextField("XXXXXX", text: $viewModel.code.value)
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .onChange(of: viewModel.code.value, perform: viewModel.codeDidChange(code:))
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
        .activity(hasActivity: viewModel.isResendInProgress || viewModel.isSubmitInProgress)
    }
}

// MARK: - LoginVerificationCodeView+ViewModel

extension LoginVerificationCodeView {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var isCodeWrong = false
        @Published var canResendCode = false
        @Published var secondsToResendCode = 60
        @Published var isResendInProgress = false
        @Published var isSubmitInProgress = false
        @Published var code: FormattableContainer<String>!

        private let container: DIContainer
        private let cancelBag = CancelBag()
        private var timer: Timer!

        var onSubmit: (() -> Void)?

        // MARK: Public Methods

        init(container: DIContainer) {
            self.container = container

            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                self?.tick()
            }
            self.code = .init("", formatter: ViewModel.format)

            cancelBag.collect {
                container.appState.bindDisplayValue(\.userData.loginForm.verificationCode, to: self, by: \.code.value)
                $code.map { $0!.value }.toInputtable(of: container.appState, at: \.value.userData.loginForm.verificationCode)
            }
        }

        func resendButtonDidTap() {
            guard let phoneNumber = container.appState.value.userData.loginForm.phoneNumber.value else { return }
            assert(secondsToResendCode == 0 && canResendCode && !isResendInProgress && !isSubmitInProgress)

            isResendInProgress = true
            container.services.firebaseService
                .sendVerificationCode(to: phoneNumber)
                .sinkToResult { [weak self] result in
                    switch result {
                    case .success(let verificationID):
                        self?.container.appState.value.userData.loginForm.verificationId = verificationID

                        self?.isResendInProgress = false
                        self?.secondsToResendCode = 60
                        self?.updateUI()
                    case .failure(let error):
                        print("verifyError: ", error.description)
                    }
                }
                .store(in: cancelBag)
        }

        func codeDidChange(code: String) {
            guard code.count == 6 else { return }
            isSubmitInProgress = true

            submitVerificationCode(code)
                .sinkToResult { [weak self] result in
                    self?.isSubmitInProgress = false

                    switch result {
                    case let .success(token):
                        self?.container.appState.value.userData.loginForm.token = token
                        self?.onSubmit?()
                        print("Successful phone verification, token: \(token)")
                    case let .failure(error):
                        self?.isCodeWrong = true
                        print("Phone verification error: \(error.description)")
                    }
                }.store(in: cancelBag)
        }

        // MARK: Private Methods

        private func tick() {
            if secondsToResendCode > 0 {
                secondsToResendCode -= 1
                updateUI()
            }
        }

        private func updateUI() {
            canResendCode = secondsToResendCode == 0 && !isResendInProgress && !isSubmitInProgress
        }

        private func submitVerificationCode(_ code: String) -> AnyPublisher<String, Error> {
            guard let verificationId = container.appState.value.userData.loginForm.verificationId else {
                let error = WineUpError.invalidAppState("Unable to extract verificationId from AppState")
                return Fail<String, Error>(error: error)
                    .eraseToAnyPublisher()
            }

            return container.services.firebaseService
                .submitVerificationCode(code, verificationId: verificationId)
        }

        private static func format(_ rawValue: String) -> String {
            return rawValue.onlyDigits
        }
    }
}

// MARK: - Preview

#if DEBUG
extension LoginVerificationCodeView.ViewModel {
    static let preview = LoginVerificationCodeView.ViewModel(container: .preview)
}

struct LoginVerificationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        LoginVerificationCodeView(viewModel: .preview, onSubmit: {})
    }
}
#endif
