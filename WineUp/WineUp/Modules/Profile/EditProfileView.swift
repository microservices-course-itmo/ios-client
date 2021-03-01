//
//  EditProfileView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 28.02.2021.
//

import SwiftUI

// MARK: - View

struct EditProfileView: View {
    @ObservedObject private(set) var viewModel: ViewModel = EditProfileView.ViewModel(container: .preview)
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 0) {
            Text("Редактирование")
                .font(.title)
                .padding()
            VStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Номер телефона:")
                        .foregroundColor(.gray)

                    TextField("+7 (XXX) XXX-XX-XX", text: $viewModel.phoneNumber.value)
                        .frame(width: 260)
                        .padding(.vertical, 14)
                        .background(Color(.systemGray6))
                        .cornerRadius(8.0)
                        .multilineTextAlignment(.center)

                }
                .padding(.bottom)

                VStack(alignment: .leading) {
                    Text("Город:")
                        .foregroundColor(.gray)
                        .padding(.leading, 32)

                    Picker("", selection: $viewModel.city) {
                        ForEach(City.displayCases) { city in
                            Text(city.titleName)
                                .tag(city)
                        }
                    }
                }
                .padding(.bottom, 32)
                Button(action: { self.presentationMode.wrappedValue.dismiss() }, label: {
                    Text("Cохранить")
                })
                .defaultStyled(isDisabled: false)
                .padding(.bottom, 16)
            }
            .padding()
        }
        .cardStyled()
        .frame(maxHeight: 450)
        .padding()
    }
}

// MARK: - EditProfileView+ViewModel

extension EditProfileView {
    final class ViewModel: ObservableObject {

        // MARK: Variables

        @Published var city: City = .saintPetersburg
        @Published var isDoneButtonActive = false
        @Published var phoneNumber = FormattableContainer("", formatter: ViewModel.formatRuPhoneNumber(phone:))

        private let container: DIContainer
        private let cancelBag = CancelBag()

        // MARK: Public Methods

        init(container: DIContainer) {
            self.container = container

            cancelBag.collect {
                container.appState.bindDisplayValue(\.userData.loginForm.city, to: self, by: \.city)
                $city.toInputtable(of: container.appState, at: \.value.userData.loginForm.city)
                container.appState.map(\.userData.loginForm.city.hasValue).bind(to: self, by: \.isDoneButtonActive)
            }
        }
        // MARK: Private Methods

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
    static let preview = EditProfileView.ViewModel(container: .preview)
    static let showModel = false
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(viewModel: .preview)
    }
}
#endif
