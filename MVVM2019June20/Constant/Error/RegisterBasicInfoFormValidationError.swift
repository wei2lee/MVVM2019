//
//  RegisterBasicInfoFormValidationError.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 02/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation

enum RegisterBasicInfoFormValidationError: Swift.Error, CustomNSError, CaseIterable {
    case invalidEmailAddress
    case passwordAndConfirmPasswordMismatch
    case passwordTooShort
    case isEmpty
    
    static var errorDomain: String {
        return "app.FormValidationError"
    }
    
    /// The error code within the given domain.
    var errorCode: Int {
        switch self {
        case .invalidEmailAddress:
            return 100
        case .passwordAndConfirmPasswordMismatch:
            return 200
        case .passwordTooShort:
            return 250
        case .isEmpty:
            return 300
        }
    }
    
    /// The user-info dictionary.
    var errorUserInfo: [String : Any] {
        switch self {
        case .invalidEmailAddress:
            return [NSErrorUserInfoKey.LocalizedDescription: "invalid email address"]
        case .passwordAndConfirmPasswordMismatch:
            return [NSErrorUserInfoKey.LocalizedDescription: "password and confirm password mismatch"]
        case .passwordTooShort:
            return [NSErrorUserInfoKey.LocalizedDescription: "password too short, must more than 6 characters"]
        case .isEmpty:
            return [NSErrorUserInfoKey.LocalizedDescription: "Must not be empty"]
        }
    }
}
