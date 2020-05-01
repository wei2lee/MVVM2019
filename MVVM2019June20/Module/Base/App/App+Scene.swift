//
//  App+Scene.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 05/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

extension AppDelegate {
    func setupScene() {
        let window = AppWindow(frame: UIScreen.main.bounds)
        let splash = DI.resolver.resolve(SplashViewControllerType.self)!
         window.rootViewController = splash
         window.makeKeyAndVisible()
         window.windowLevel = UIWindow.Level(rawValue: 0.1)
         self.window = window
    }
}
