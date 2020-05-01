//
//  AppLifeCycle.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 22/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import SwifterSwift

extension AppDelegate {
    func onApplicationFinishDidLaunchCompleted() {
        let Defaults = DI.resolver.resolve(UserDefaults.self)!
        Defaults[.lastLaunchAppVersion] = SwifterSwift.appVersion ?? ""
        Defaults[.lastLaunchAppBuild] = SwifterSwift.appBuild ?? ""
        Defaults[.appLaunchBefore] = true
    }
}
