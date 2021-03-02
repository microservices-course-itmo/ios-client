//
//  LoginView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import Foundation
import SwiftUI
import Combine

// MARK: - LoginView+Form

extension LoginView {
    struct Form: Equatable {
        var phoneNumber = Inputtable(placeholder: "")
        var verificationCode = Inputtable(placeholder: "")
        var name = Inputtable(placeholder: "")
        var birthday = Inputtable(placeholder: Date.maxBirthday)
        var city = Inputtable(initialValue: City.saintPetersburg, placeholder: .notSelected)

        var verificationId: PhoneVerificationId?
        var token: FirebaseToken?
    }
}

// MARK: - LoginView+Page

extension LoginView {
    enum Page {
        case ageQuestion, ageRestriction, phoneNumber, verificationCode, name, birthday, city, personalDataConcent
    }
}

// MARK: - LoginView+ViewModel

extension LoginView {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var currentPage: Int = 0
        @Published var pages: [Page] = [.ageQuestion]
        @Published var registration: Loadable<Void> = .notRequested

        private let container: DIContainer

        // MARK: Public

        init(container: DIContainer) {
            self.container = container
        }

        func olderThan18ButtonDidTap() {
            nextPage(.phoneNumber)
        }

        func youngerThan18ButtonDidTap() {
            nextPage(.ageRestriction)
        }

        func phoneNumberDidSubmit() {
            nextPage(.verificationCode)
        }

        func verificationCodeDidSubmit() {
            let bag = CancelBag()
            container.appState.value.routing.didLogin.setIsLoading(cancelBag: bag)

            container.services.authenticationService
                .login()
                .sinkToResult { result in
                    switch result {
                    case let .failure(error):
                        print("Login error: \(error.description)")
                        self.container.appState.value.routing.didLogin = .loaded(false)
                        self.nextPage(.name)
                    case .success:
                        self.container.appState.value.routing.didLogin = .loaded(true)
                        self.container.appState.value.userData.loginForm = .init()
                    }
                }
                .store(in: bag)
        }

        func nameDidSubmit() {
            nextPage(.birthday)
        }

        func birthdayDidSubmit() {
            nextPage(.city)
        }

        func cityDidSubmit() {
            nextPage(.personalDataConcent)
        }

        func personalDataDidConcent() {
            finish()
        }

        var loginPhoneInputViewModel: LoginPhoneInput.ViewModel {
            .init(container: container)
        }

        var loginVerificationCodeViewModel: LoginVerificationCodeView.ViewModel {
            .init(container: container)
        }

        var loginNameInputViewModel: LoginNameInput.ViewModel {
            .init(container: container)
        }

        var loginBirthdayInputViewModel: LoginBirthdayInput.ViewModel {
            .init(container: container)
        }

        var loginCityInputViewModel: LoginCityInput.ViewModel {
            .init(container: container)
        }

        // MARK: Private

        private func nextPage(_ page: Page? = nil) {
            if let page = page {
                pages.append(page)
            }

            withAnimation(.easeInOut(duration: 0.4)) {
                self.currentPage += 1
            }

            assert((0..<pages.count).contains(currentPage))
        }

        private func finish() {
            let form = container.appState.value.userData.loginForm

            guard let name = form.name.value,
                  let birthday = form.birthday.value,
                  let city = form.city.value else {
                assertionFailure()
                return
            }

            let bag = CancelBag()

            registration.setIsLoading(cancelBag: bag)

            container.services.firebaseService
                .getToken()
                .flatMap { token -> AnyPublisher<UserJson, Error> in
                    let form = UserJson.RegistrationForm(
                        birthday: birthday,
                        cityId: city.id,
                        fireBaseToken: token,
                        name: name
                    )

                    return self.container.services.authenticationService.register(with: form)
                }
                .sinkToResult { result in
                    switch result {
                    case let .failure(error):
                        print("Login error: \(error.description)")
                        self.registration = .failed(error)
                    case let .success(user):
                        print("Finish login of user \(user)")
                        self.container.appState.value.routing.didLogin = .loaded(true)
                        self.registration = .loaded(())
                    }
                }
                .store(in: bag)
        }
    }
}

// MARK: - Helpers

private extension Date {
    static var maxBirthday: Date {
        Date().plus(DateComponents(year: -18))
    }
}

// MARK: - Preview

#if DEBUG
extension LoginView.ViewModel {
    static let preview = LoginView.ViewModel(container: .preview)
}
#endif
