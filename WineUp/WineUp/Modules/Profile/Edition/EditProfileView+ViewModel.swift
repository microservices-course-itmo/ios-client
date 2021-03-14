//
//  EditProfileView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 01.03.2021.
//

import Foundation
import Firebase

// MARK: - EditProfileView+ViewModel

extension EditProfileView {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var city: City = .saintPetersburg
        @Published var isDoneButtonActive = false
        @Published var phoneNumber = FormattableContainer("", formatter: ViewModel.formatRuPhoneNumber(phone:))
        @Published var updatingProfileSuccess: Loadable<Void> = .notRequested
        @Published var sendingVerificationCodeSuccess: Loadable<Void> = .notRequested
        @Published var updatingPhoneNumberSuccess: Loadable<Void> = .notRequested

        private let container: DIContainer
        private let cancelBag = CancelBag()
        private var verificationId: PhoneVerificationId?

        // MARK: Public Methods

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                $phoneNumber.map { $0.value.count == 18 }.bind(to: self, by: \.isDoneButtonActive)
            }

            let user = container.services.authenticationService.user.value
            city = user?.city ?? .saintPetersburg
            phoneNumber.value = user?.phoneNumber ?? ""
        }

        var phoneNumberUpdateNeeded: Bool {
            guard let firebasePhoneNumber = Auth.auth().currentUser?.phoneNumber else {
                assertionFailure()
                return false
            }
            return firebasePhoneNumber != phoneNumber.value
        }

        func updatePhoneNumber() {
            assert(phoneNumber.value.count == 18)
            let phoneNumber = "+" + self.phoneNumber.value.onlyDigits
            let bag = CancelBag()
            sendingVerificationCodeSuccess.setIsLoading(cancelBag: bag)

            container.services.firebaseService
                .sendVerificationCode(to: phoneNumber)
                .map {
                    self.verificationId = $0
                    return
                }
                .sinkToLoadable {
                    self.sendingVerificationCodeSuccess = $0
                }
                .store(in: bag)
        }

        func submitVerificationCode(_ code: String) {
            guard let verificationId = verificationId else {
                assertionFailure()
                return
            }

            let bag = CancelBag()
            updatingPhoneNumberSuccess.setIsLoading(cancelBag: bag)

            container.services.firebaseService
                .updatePhoneNumber(code, verificationId: verificationId)
                .sinkToLoadable {
                    self.updatingPhoneNumberSuccess = $0
                }
                .store(in: bag)
        }

        func cancelPhoneVerification() {
            verificationId = nil
            updatingPhoneNumberSuccess = .failed(WineUpError.canceledByUser)
        }

        func updateProfile() {
            assert(phoneNumber.value.count == 18)
            let bag = CancelBag()

            updatingProfileSuccess.setIsLoading(cancelBag: bag)
            let form = UserJson.UpdateForm(cityId: city.id)

            container.services
                .authenticationService
                .updateCurrentUser(with: form)
                .sinkToResult(self.handle(updateResult:))
                .store(in: bag)
        }

        // MARK: Private Methods

        private func handle(updateResult result: Result<UserJson, Error>) {
            switch result {
            case .success:
                updatingProfileSuccess = .loaded(())
            case let .failure(error):
                updatingProfileSuccess = .failed(error)
            }
        }

        private static func formatRuPhoneNumber(phone: String) -> String {
            return format(mask: "+X (XXX) XXX-XX-XX", phone: phone)
        }

        private static func format(mask: String, phone: String) -> String {
            var numbers = phone.onlyDigits
            var result = ""
            var index = numbers.startIndex

            // Insert '7' at first position if needed
            if numbers.first != "7" && !numbers.isEmpty {
                if numbers.first == "8" {
                    numbers.remove(at: numbers.index(numbers.startIndex, offsetBy: 0))
                }
                numbers.insert("7", at: numbers.index(numbers.startIndex, offsetBy: 0))
            }

            for char in mask where index < numbers.endIndex {
                if char == "X" {
                    result.append(numbers[index])
                    index = numbers.index(after: index)
                } else {
                    result.append(char)
                }
            }
            return result
        }
    }
}

// MARK: - Preview

#if DEBUG
extension EditProfileView.ViewModel {
    static var preview: EditProfileView.ViewModel {
        .init(container: .preview)
    }
}
#endif
