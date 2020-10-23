//
//  LoginView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import Foundation
import SwiftUI

// MARK: - LoginView+ViewModel

extension LoginView {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var currentPage: Int = 0
        @Published var pages: [Page] = [.ageQuestion]

        // MARK: Public

        func olderThan18ButtonDidTap() {
            nextPage(.phoneNumber)
        }

        func youngerThan18ButtonDidTap() {
            nextPage(.ageRestriction)
        }

        func phoneNumberDoneButtonDidTap() {
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

        func loginPhoneInputViewModel() -> LoginPhoneInput.ViewModel {
            return .init(onNextButtonTap: self.phoneNumberDoneButtonDidTap)
        }

        func loginVerificationCodeViewModel() -> LoginVerificationCodeView.ViewModel {
            return .init(onSubmit: self.verificationCodeDidSubmit)
        }

        func loginNameInputViewModel() -> LoginNameInput.ViewModel {
            return .init(onSubmit: self.nameDidSubmit)
        }

        func loginBirthdayInputViewModel() -> LoginBirthdayInput.ViewModel {
            return .init(onSubmit: self.birthdayDidSubmit)
        }

        func loginCityInputViewModel() -> LoginCityInput.ViewModel {
            return .init(onSubmit: self.cityDidSubmit)
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

        }
    }
}

// MARK: - LoginView+Page

extension LoginView {
    enum Page {
        case ageQuestion, ageRestriction, phoneNumber, verificationCode, name, birthday, city, personalDataConcent
    }
}
