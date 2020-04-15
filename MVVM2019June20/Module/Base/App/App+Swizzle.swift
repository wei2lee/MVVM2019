//
//  App+Swizzle.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 03/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

extension AppDelegate {
    func setupSwizzle() {
        UIViewController.vcci_swizzle()
        UIViewController.dowfrop_swizzle()
    }
}

