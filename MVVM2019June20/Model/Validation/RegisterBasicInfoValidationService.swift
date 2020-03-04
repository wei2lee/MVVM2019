//
//  RegisterBasicInfoValidationService.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 02/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation


class RegisterBasicInfoValidationService : RegisterBasicInfoValidationServiceType {
    static let shared = RegisterBasicInfoValidationService()
    @Injected var formValidationHelper: FormValidationHelper
    func validateFirstname(_ value: String?) -> RegisterBasicInfoFormValidationError? {
        if value == nil || value!.isEmpty {
            return RegisterBasicInfoFormValidationError.isEmpty
        }
        return nil
    }
    func validateLastname(_ value: String?) -> RegisterBasicInfoFormValidationError? {
        if value == nil || value!.isEmpty {
            return RegisterBasicInfoFormValidationError.isEmpty
        }
        return nil
    }
    func validateEmail(_ value: String?) -> RegisterBasicInfoFormValidationError? {
        if value == nil || value!.isEmpty {
            return RegisterBasicInfoFormValidationError.isEmpty
        }
        if !formValidationHelper.validateEmailAddress(value) {
            return RegisterBasicInfoFormValidationError.invalidEmailAddress
        }
        return nil
    }
    func validatePassword(_ value: String?) -> RegisterBasicInfoFormValidationError? {
        if value == nil || value!.isEmpty {
            return RegisterBasicInfoFormValidationError.isEmpty
        }
        if value!.count <= 6 {
            return RegisterBasicInfoFormValidationError.passwordTooShort
        }
        return nil
    }
    func validatePasswordAndConfirmPassword(_ password: String?, _ confirmPassword: String?) -> RegisterBasicInfoFormValidationError? {
        if confirmPassword == nil || confirmPassword!.isEmpty {
            return RegisterBasicInfoFormValidationError.isEmpty
        }
        let a1 = password ?? ""
        let a2 = confirmPassword ?? ""
        if a1 != a2 {
            return RegisterBasicInfoFormValidationError.passwordAndConfirmPasswordMismatch
        }
        return nil
    }
}
