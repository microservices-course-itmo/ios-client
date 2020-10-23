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
            return LoginPhoneInput(viewModel: viewModel.loginPhoneInputViewModel()).anyView
        case .verificationCode:
            return LoginVerificationCodeView(viewModel: viewModel.loginVerificationCodeViewModel()).anyView
        case .name:
            return LoginNameInput(viewModel: viewModel.loginNameInputViewModel()).anyView
        case .birthday:
            return LoginBirthdayInput(viewModel: viewModel.loginBirthdayInputViewModel()).anyView
        case .city:
            return LoginCityInput(viewModel: viewModel.loginCityInputViewModel()).anyView
        case .personalDataConcent:
            return LoginPersonalDataConcentView(onConcent: viewModel.personalDataDidConcent).anyView
        }
    }
}

// MARK: - Preview

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init())
    }
}
#endif