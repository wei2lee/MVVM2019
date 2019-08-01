//
//  ViewControllerCycleType.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 22/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

@objc protocol ViewControllerCycleImplType {
    @objc var viewWillAppearCount:Int { set get }
    @objc var viewDidAppearCount:Int { set get }
    @objc var isViewVisible: Bool { set get }
}


