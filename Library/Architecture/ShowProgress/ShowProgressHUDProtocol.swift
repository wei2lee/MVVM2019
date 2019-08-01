//
//  ShowProgressHUDProtocol.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 22/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

@objc protocol ShowProgressHUDProtocol: class {
    func showProgressHUD()
    func showProgressHUD(label:String)
    func hideProgressHUD()
}
