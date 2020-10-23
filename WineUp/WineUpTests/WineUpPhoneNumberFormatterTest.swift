//
//  WineUpPhoneNumberFormatterTest.swift
//  WineUpTests
//
//  Created by Влад on 12.10.2020.
//

import XCTest
@testable import WineUp

class WineUpPhoneNumberFormatterTest: XCTestCase {

    func testPhoneFormatterTestCase() {
        runPhoneFormatterTest(withRawPhone: "890055535", andResult: "+7 (900) 555-35")
        runPhoneFormatterTest(withRawPhone: "+79005553535", andResult: "+7 (900) 555-35-35")
        runPhoneFormatterTest(withRawPhone: "79005553535", andResult: "+7 (900) 555-35-35")
        runPhoneFormatterTest(withRawPhone: "89005553535", andResult: "+7 (900) 555-35-35")
        runPhoneFormatterTest(withRawPhone: "9005553535", andResult: "+7 (900) 555-35-35")
        runPhoneFormatterTest(withRawPhone: "8l9f0s0d5a5:kkd5*d#$3f5g3h5", andResult: "+7 (900) 555-35-35")
        runPhoneFormatterTest(withRawPhone: "79005553535000000000", andResult: "+7 (900) 555-35-35")
        runPhoneFormatterTest(withRawPhone: "90055535357", andResult: "+7 (900) 555-35-35")
    }

    private func runPhoneFormatterTest(withRawPhone phone: String, andResult expectedResult: String) {
        let loginChecker = LoginPhoneInput.ViewModel(onNextButtonTap: {})
        loginChecker.phoneNumber.value = phone
        XCTAssertEqual(loginChecker.phoneNumber.value, expectedResult)
    }
}
