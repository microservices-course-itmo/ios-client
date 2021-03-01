//
//  EditProfileView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 01.03.2021.
//

import Foundation

// MARK: - EditProfileView+ViewModel

extension EditProfileView {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var city: City = .saintPetersburg
        @Published var isDoneButtonActive = false
        @Published var phoneNumber = FormattableContainer("", formatter: ViewModel.formatRuPhoneNumber(phone:))
        @Published var updatingProfileSuccess: Loadable<Void> = .notRequested

        private let container: DIContainer
        private let cancelBag = CancelBag()

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

        func updateProfile() {
            assert(phoneNumber.value.count == 18)
            let bag = CancelBag()

            updatingProfileSuccess.setIsLoading(cancelBag: bag)
            let form = UserJson.UpdateForm(cityId: city.id, phoneNumber: "+" + phoneNumber.value.onlyDigits)

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
