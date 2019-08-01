//
//  DefaultKeys.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 20/06/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    //MARK: Startup
    static let forceLogoutOnAppStartup = DefaultsKey<Bool>("forceLogoutOnAppStartup", defaultValue: false)
    static let appLaunchBefore = DefaultsKey<Bool>("appLaunchBefore", defaultValue: false)
    static let lastLaunchAppVersion = DefaultsKey<String>("lastLaunchAppVersion", defaultValue: "")
    static let lastLaunchAppBuild = DefaultsKey<String>("lastLaunchAppBuild", defaultValue: "")
    //MARK: Login
    static let isActivated = DefaultsKey<Bool>("isActivated", defaultValue: false)
    static let lastRequestActivationDate = DefaultsKey<Date?>("lastRequestActivationDate")
}
