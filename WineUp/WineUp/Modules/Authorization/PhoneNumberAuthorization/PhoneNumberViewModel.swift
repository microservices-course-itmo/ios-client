//
//  PhoneNumberModel.swift
//  WineUp
//
//  Created by Влад on 10.10.2020.
//

import Foundation
import Combine
import SwiftUI

class PhoneNumberViewModel: ObservableObject {

    @Published var correctNum = "" {
        didSet {
            if correctNum != oldValue {
                correctNum = formatter(mask: "+X (XXX) XXX-XX-XX", phone: correctNum)
            }
        }
    }

    func formatter(mask: String, phone: String) -> String {
        var numbers = phone.filter("0123456789".contains)
        var result = ""
        var index = numbers.startIndex

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

    func loginButtonDidTap() {

    }

    func continueWithoutAuthButtonDidTap() {

    }
}
