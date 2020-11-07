//
//  FirebaseService.swift
//  WineUp
//
//  Created by Александр Пахомов on 04.11.2020.
//

import Foundation
import Combine
import Firebase

protocol FirebaseService {
    /// Sends SMS with verification code to phone number, publisher returns verificationId
    func sendVerificationCode(to phoneNumber: String) -> AnyPublisher<String, Error>
    /// Executes Firebase signIn method and returns token in publisher
    func submitVerificationCode(_ code: String, verificationId: String) -> AnyPublisher<String, Error>
    /// Current Firebase user
    var currentUser: User? { get }
    var isAuthenticated: Bool { get }
}

extension FirebaseService {
    var isAuthenticated: Bool {
        currentUser != nil
    }
}

// TODO: Implementation needed
//final class RealFirebaseService: FirebaseService {
//
//}
