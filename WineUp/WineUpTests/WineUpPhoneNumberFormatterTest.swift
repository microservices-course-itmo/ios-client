//
//  WineUpPhoneNumberFormatterTest.swift
//  WineUpTests
//
//  Created by Влад on 12.10.2020.
//

import XCTest
@testable import WineUp

class WineUpPhoneNumberFormatterTest: XCTestCase {

    func testPhoneFormatter() {
          let loginChecker = PhoneNumberViewModel()
          XCTAssertEqual(loginChecker.formatter(mask: "+X (XXX) XXX-XX-XX", phone: "890055535"), "+7 (900) 555-35")
          XCTAssertEqual(loginChecker.formatter(mask: "+X (XXX) XXX-XX-XX", phone: "+79005553535"), "+7 (900) 555-35-35")
          XCTAssertEqual(loginChecker.formatter(mask: "+X (XXX) XXX-XX-XX", phone: "79005553535"), "+7 (900) 555-35-35")
          XCTAssertEqual(loginChecker.formatter(mask: "+X (XXX) XXX-XX-XX", phone: "89005553535"), "+7 (900) 555-35-35")
          XCTAssertEqual(loginChecker.formatter(mask: "+X (XXX) XXX-XX-XX", phone: "9005553535"), "+7 (900) 555-35-35")
          XCTAssertEqual(loginChecker.formatter(mask: "+X (XXX) XXX-XX-XX", phone: "8l9f0s0d5a5:kkd5*d#$3f5g3h5"), "+7 (900) 555-35-35")
          XCTAssertEqual(loginChecker.formatter(mask: "+X (XXX) XXX-XX-XX", phone: "79005553535000000000"), "+7 (900) 555-35-35")
          XCTAssertEqual(loginChecker.formatter(mask: "+X (XXX) XXX-XX-XX", phone: "90055535357"), "+7 (900) 555-35-35")
      }
}
