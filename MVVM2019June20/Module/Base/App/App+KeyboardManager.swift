//
//  App+KeyboardManager.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 03/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import IQKeyboardManagerSwift

extension AppDelegate {
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses = [IQKeyboardToolBarPreviousNextAllowedView.self,
                                                                      IQKeyboardToolBarPreviousNextAllowedStackView.self]
    }
}
