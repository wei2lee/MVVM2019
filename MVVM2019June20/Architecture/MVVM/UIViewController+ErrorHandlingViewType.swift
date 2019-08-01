//
//  UIViewController+ErrorHandlingViewType.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 04/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift

extension UIViewController: ErrorHandlingViewType {
    func exitToLogin() {
    }
    func showLoginSessionExpire(error:NSError) -> Driver<Void> {
        return present(error: error)
    }
}
