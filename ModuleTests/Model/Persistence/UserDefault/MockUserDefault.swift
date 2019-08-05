//
//  UserDefault.swift
//  ModuleTests
//
//  Created by Yee Chuan Lee on 05/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension UserDefaults {
    static let NotActivated: UserDefaults = {
        var ret = UserDefaults()
        ret[.isActivated] = false
        return ret
    }()
    static let Activated: UserDefaults = {
        var ret = UserDefaults()
        ret[.isActivated] = true
        return ret
    }()
    
}
