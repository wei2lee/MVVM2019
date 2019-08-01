//
//  LoginFormValdiationServiceType.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 22/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

protocol LoginFormValidationServiceType {
    func validate(username: String?, password: String?) -> LoginFormValidationError? 
}
