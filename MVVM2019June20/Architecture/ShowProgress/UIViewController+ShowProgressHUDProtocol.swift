//
//  UIViewController+ShowProgressHUDProtocol.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 27/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift

extension UIViewController: ShowProgressHUDProtocol {
    func showProgressHUD() {
        //SwifterSwift.sharedApplication.keyWindow?.showProgressHUD()
        self.view.showProgressHUD()
    }
    
    func showProgressHUD(label: String) {
        //SwifterSwift.sharedApplication.keyWindow?.showProgressHUD(label: label)
        self.view.showProgressHUD(label: label)
    }
    
    func hideProgressHUD() {
        //SwifterSwift.sharedApplication.keyWindow?.hideProgressHUD()
        self.view.hideProgressHUD()
    }
}
