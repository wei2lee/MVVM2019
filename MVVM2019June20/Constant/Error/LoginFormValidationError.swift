//
//  LoginFormValidationError.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 03/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

enum LoginFormValidationError: Swift.Error, CustomNSError, CaseIterable {
    case usernameIsEmpty
    case passwordIsEmpty
    case usernameAndPasswordIsEmpty
    case generic
    
    static var errorDomain: String {
        return "app.LoginFormValidationError"
    }
    
    /// The error code within the given domain.
    var errorCode: Int {
        switch self {
        case .usernameIsEmpty:
            return 100
        case .passwordIsEmpty:
            return 200
        case .usernameAndPasswordIsEmpty:
            return 300
        case .generic:
            return 9999
        }
    }
    
    /// The user-info dictionary.
    var errorUserInfo: [String : Any] {
        switch self {
        case .usernameIsEmpty:
            return [NSErrorUserInfoKey.LocalizedDescription: "usernameIsEmpty"]
        case .passwordIsEmpty:
            return [NSErrorUserInfoKey.LocalizedDescription: "passwordIsEmpty"]
        case .usernameAndPasswordIsEmpty:
            return [NSErrorUserInfoKey.LocalizedDescription: "usernameAndPasswordIsEmpty"]
        case .generic:
            return [NSErrorUserInfoKey.LocalizedDescription: "Somemthing went wrong"]
        }
    }
}
