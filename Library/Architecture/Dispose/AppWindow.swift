//
//  AppWindow.swift
//  MVVM2019June20
//
//  Created by UF-Jacky.Lee on 15/04/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import UIKit

class AppWindow: UIWindow {
    override var rootViewController: UIViewController? {
        didSet {
            oldValue?.dispose()
        }
    }
}
