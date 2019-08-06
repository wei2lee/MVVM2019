//
//  App+Flex.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 03/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import FLEX

extension AppDelegate {
    func setupFlex() {
        FLEXManager.shared().isNetworkDebuggingEnabled = true
        FLEXManager.shared()?.showExplorer()
    }
}
