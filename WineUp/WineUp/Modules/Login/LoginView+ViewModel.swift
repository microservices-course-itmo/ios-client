//
//  LoginView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import Foundation
import SwiftUI

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
            nextPage(.name)
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

            print("""
            Finish login of user
                name: \(name)
                birthday: \(birthday)
                city: \(city)
            """)

            container.appState.value.routing.didLogin = true
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
