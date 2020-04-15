//
//  ActivationFormValidatorError.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 22/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

enum ActivationFormValidationError: Swift.Error, CustomNSError, CaseIterable {
    case isEmpty
    case lessThan6Character
    case containNonDigit
    
    static var errorDomain: String {
        return "app.ActivationFormValidatorError"
    }
    
    /// The error code within the given domain.
    var errorCode: Int {
        switch self {
        case .isEmpty:
            return 100
        case .lessThan6Character:
            return 200
        case .containNonDigit:
            return 300
        }
    }
    
    /// The user-info dictionary.
    var errorUserInfo: [String : Any] {
        switch self {
        case .isEmpty:
            return [NSErrorUserInfoKey.LocalizedDescription: "isEmpty"]
        case .lessThan6Character:
            return [NSErrorUserInfoKey.LocalizedDescription: "lessThan6Character"]
        case .containNonDigit:
            return [NSErrorUserInfoKey.LocalizedDescription: "containNonDigit"]
        }
    }
}

