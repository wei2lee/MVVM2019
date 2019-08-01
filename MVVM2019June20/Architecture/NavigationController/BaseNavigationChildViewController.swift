//
//  SMSNavigationChildViewController.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 08/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

@objc protocol BaseNavigationChildViewController {
    @objc optional func willShowInNavigationController(navigationController: UINavigationController, animated: Bool)
    @objc optional var isNavigationBarHidden: Bool { get }
}
