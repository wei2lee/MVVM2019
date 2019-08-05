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
    public static let forceLogoutOnAppStartup = DefaultsKey<Bool>("forceLogoutOnAppStartup", defaultValue: false)
    public static let appLaunchBefore = DefaultsKey<Bool>("appLaunchBefore", defaultValue: false)
    public static let lastLaunchAppVersion = DefaultsKey<String>("lastLaunchAppVersion", defaultValue: "")
    public static let lastLaunchAppBuild = DefaultsKey<String>("lastLaunchAppBuild", defaultValue: "")
    //MARK: Login
    public static let isActivated = DefaultsKey<Bool>("isActivated", defaultValue: false)
    public static let lastRequestActivationDate = DefaultsKey<Date?>("lastRequestActivationDate")
}
