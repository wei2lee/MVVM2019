//
//  FormValidationHelper.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 02/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation

class FormValidationHelper {
    func validateEmailAddress(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailPred.evaluate(with: email)
        return result
    }
}
