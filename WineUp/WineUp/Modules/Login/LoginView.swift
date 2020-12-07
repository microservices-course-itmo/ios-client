//
//  LoginView.swift
//  WineUp
//
//  Created by Александр Пахомов on 13.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let rootVStackSpacing: CGFloat = 30
}

private extension Font {
    static let wineUp: Font = .system(size: 64, weight: .semibold, design: .default)
}

// MARK: - View

struct LoginView: View {

    @ObservedObject private(set) var viewModel: ViewModel
    @State private var currentPage: Int = 0

    var body: some View {
        switch viewModel.registration {
        case .notRequested:
            return pagesContent().anyView
        case .isLoading:
            return pagesContent().activity(hasActivity: true).anyView
        case let .failed(error):
            return Text("Authentication error: \(error.description)").anyView
        case .loaded:
            return Text("Success!").anyView
        }
    }

    private func pagesContent() -> some View {
        VStack(alignment: .center, spacing: .rootVStackSpacing) {
            Spacer()
            Text("WineUp")
                .font(.wineUp)
                .padding()

            LazyPager(
                pageCount: viewModel.pages.count,
                currentIndex: $viewModel.currentPage,
                content: self.pageFor(index:)
            )
            Spacer()
        }
    }

    private func pageFor(index: Int) -> AnyView {
        let page = viewModel.pages[index]
        switch page {
        case .ageQuestion:
            return LoginAgeQuestionView(
                onOlderThan18ButtonTap: viewModel.olderThan18ButtonDidTap,
                onYoungerThan18ButtonTap: viewModel.youngerThan18ButtonDidTap
            ).anyView
        case .ageRestriction:
            return LoginAgeRestrictionView().anyView
        case .phoneNumber:
            return LoginPhoneInput(
                viewModel: viewModel.loginPhoneInputViewModel,
                onSubmit: viewModel.phoneNumberDidSubmit
            ).anyView
        case .verificationCode:
            return LoginVerificationCodeView(
                viewModel: viewModel.loginVerificationCodeViewModel,
                onSubmit: viewModel.verificationCodeDidSubmit
            ).anyView
        case .name:
            return LoginNameInput(viewModel: viewModel.loginNameInputViewModel, onSubmit: viewModel.nameDidSubmit).anyView
        case .birthday:
            return LoginBirthdayInput(
                viewModel: viewModel.loginBirthdayInputViewModel,
                onSubmit: viewModel.birthdayDidSubmit
            ).anyView
        case .city:
            return LoginCityInput(viewModel: viewModel.loginCityInputViewModel, onSubmit: viewModel.cityDidSubmit).anyView
        case .personalDataConcent:
            return LoginPersonalDataConcentView(onConcent: viewModel.personalDataDidConcent).anyView
        }
    }
}

// MARK: - Preview

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .preview)
    }
}
#endif
