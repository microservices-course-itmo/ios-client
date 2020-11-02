//
//  LoginVerificationCodeView.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import SwiftUI
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
                container.appState.map { $0.userData.loginForm.verificationCode.value }.onChange { [weak self] in
                    self?.codeDidChange(code: $0 ?? "")
                }
            }
        }

        func resendButtonDidTap() {
            guard let phoneNumber = container.appState.value.userData.loginForm.phoneNumber.value else { return }
            assert(secondsToResendCode == 0 && canResendCode && !isResendInProgress && !isSubmitInProgress)

            isResendInProgress = true
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
                if let error = error {
                    print("verifyError: ", error.localizedDescription)
                    return
                }

                self?.container.appState.value.userData.loginForm.verificationId = verificationID

                self?.isResendInProgress = false
                self?.secondsToResendCode = 60
                self?.updateUI()
            }
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

        private func codeDidChange(code: String) {
            guard code.count == 6 else { return }

            isSubmitInProgress = true
            submitVerificationCode(code) { [weak self] result in
                guard let self = self else { return }
                self.isSubmitInProgress = false

                switch result {
                case let .failure(error):
                    self.isCodeWrong = true
                    print("Phone verification error: \(error.localizedDescription)")
                case let .success(token):
                    print("Successful phone verification, token: \(token)")
                    self.container.appState.value.userData.loginForm.token = token
                    self.onSubmit?()
                }
            }
        }

        private func submitVerificationCode(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
            guard let verificationId = container.appState.value.userData.loginForm.verificationId else {
                completion(.failure(WineUpError.invalidAppState("Unable to extract verificationId from AppState")))
                return
            }

            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationId,
                verificationCode: code
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let user = authResult?.user else {
                    completion(.failure(WineUpError.invalidState("Unable to extract user from successful auth result")))
                    return
                }

                user.getIDToken { token, error in
                    if let error = error {
                        completion(.failure(error))
                    }

                    guard let token = token else {
                        completion(.failure(WineUpError.invalidState("Unable to extract token from successful auth result")))
                        return
                    }

                    completion(.success(token))
                }
            }
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
