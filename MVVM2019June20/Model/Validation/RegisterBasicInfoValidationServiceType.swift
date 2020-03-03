//
//  RegisterBasicInfoValidationServiceType.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 02/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation

protocol RegisterBasicInfoValidationServiceType {
    func validateFirstname(_ value: String?) -> RegisterBasicInfoFormValidationError?
    func validateLastname(_ value: String?) -> RegisterBasicInfoFormValidationError?
    func validateEmail(_ value: String?) -> RegisterBasicInfoFormValidationError?
    func validatePassword(_ value: String?) -> RegisterBasicInfoFormValidationError?
    func validatePasswordAndConfirmPassword(_ password: String?, _ confirmPassword: String?) -> RegisterBasicInfoFormValidationError?
}
