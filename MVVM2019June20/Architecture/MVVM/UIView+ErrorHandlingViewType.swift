//
//  UIView+ShowLoginSessionExpireViewType.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 04/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIView: ErrorHandlingViewType {
    func exitToLogin() {
        self.parentViewController?.exitToLogin()
    }
    var errorHandlingView:ErrorHandlingViewType? {
        return self.parentViewController
    }
    func showLoginSessionExpire(error:NSError) -> Driver<Void> {
        return self.parentViewController?.showLoginSessionExpire(error: error) ?? Driver.empty()
    }
}

