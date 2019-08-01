//
//  AuthConstant.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

enum EnumLoginComparision {
    case sameUser(current: LoginSession)
    case diffUser(current: LoginSession, previous: LoginSession)
    case newUser(current: LoginSession)
    
    var current: LoginSession {
        switch self {
        case .sameUser(let current):
            return current
        case .diffUser(let current, _):
            return current
        case .newUser(let current):
            return current
        }
    }
}
