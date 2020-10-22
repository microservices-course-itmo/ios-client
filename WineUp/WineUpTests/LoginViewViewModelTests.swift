//
//  LoginViewViewModelTests.swift
//  WineUpTests
//
//  Created by Александр Пахомов on 22.10.2020.
//

import XCTest
@testable import WineUp

class LoginViewViewModelTests: XCTestCase {

    private var viewModel: LoginView.ViewModel!

    override func setUp() {
        super.setUp()
        viewModel = .init()
    }

    func testPagesLogicYounger18() {
        XCTAssertEqual(currentPage, .ageQuestion)

        viewModel.youngerThan18ButtonDidTap()
        XCTAssertEqual(currentPage, .ageRestriction)
    }

    func testPagesLogicOlder18() {
        XCTAssertEqual(currentPage, .ageQuestion)

        viewModel.olderThan18ButtonDidTap()
        XCTAssertEqual(currentPage, .phoneNumber)

        viewModel.phoneNumberDoneButtonDidTap()
        XCTAssertEqual(currentPage, .verificationCode)

        viewModel.verificationCodeDidSubmit()
        XCTAssertEqual(currentPage, .name)

        viewModel.nameDidSubmit()
        XCTAssertEqual(currentPage, .birthday)

        viewModel.birthdayDidSubmit()
        XCTAssertEqual(currentPage, .city)

        viewModel.cityDidSubmit()
        XCTAssertEqual(currentPage, .personalDataConcent)
    }

    private var currentPage: LoginView.Page {
        viewModel.pages[viewModel.currentPage]
    }
}
