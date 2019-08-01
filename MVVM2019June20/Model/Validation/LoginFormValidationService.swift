//
//  LoginFormValidationService.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 03/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation


class LoginFormValidationService : LoginFormValidationServiceType {
    static let shared = LoginFormValidationService()
    func validate(username: String?, password: String?) -> LoginFormValidationError? {
        if username.isNilOrEmpty && password.isNilOrEmpty {
            return .usernameAndPasswordIsEmpty
        } else if username.isNilOrEmpty {
            return .usernameIsEmpty
        } else if password.isNilOrEmpty {
            return .passwordIsEmpty
        } else {
            return nil
        }
    }
}
