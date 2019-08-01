//
//  UIViewController+SwizzleViewCycle.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 01/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

fileprivate func vcci_swizzle_debug(_ closure: @autoclosure () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
    //Log.debug(closure(), functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo)
}

extension UIViewController {
    static func vcci_swizzle() {
        
        func swizzle_viewDidLoad() {
            let originalSelector = #selector(viewDidLoad)
            let swizzledSelector = #selector(vcci_viewDidLoad)
            swizzling(UIViewController.self, originalSelector, swizzledSelector)
        }
        
        func swizzle_viewWillAppear() {
            let originalSelector = #selector(viewWillAppear(_:))
            let swizzledSelector = #selector(vcci_viewWillAppear(_:))
            swizzling(UIViewController.self, originalSelector, swizzledSelector)
        }
        
        func swizzle_viewDidAppear() {
            let originalSelector = #selector(viewDidAppear(_:))
            let swizzledSelector = #selector(vcci_viewDidAppear(_:))
            swizzling(UIViewController.self, originalSelector, swizzledSelector)
        }
        
        func swizzle_viewWillDisappear() {
            let originalSelector = #selector(viewWillDisappear(_:))
            let swizzledSelector = #selector(vcci_viewWillDisappear(_:))
            swizzling(UIViewController.self, originalSelector, swizzledSelector)
        }
        
        func swizzle_viewDidDisappear() {
            let originalSelector = #selector(viewDidDisappear(_:))
            let swizzledSelector = #selector(vcci_viewDidDisappear(_:))
            swizzling(UIViewController.self, originalSelector, swizzledSelector)
        }
        
        swizzle_viewDidLoad()
        swizzle_viewWillAppear()
        swizzle_viewDidAppear()
        swizzle_viewWillDisappear()
        swizzle_viewDidDisappear()
    }
    @objc func vcci_viewDidLoad() {
        vcci_swizzle_debug("\(self)@start")
        vcci_viewDidLoad()
        isViewVisible = true
        vcci_swizzle_debug("\(self)@end")
    }
    @objc func vcci_viewWillAppear(_ animated: Bool) {
        vcci_swizzle_debug("\(self)@start")
        vcci_viewWillAppear(animated)
        viewWillAppearCount += 1
        vcci_swizzle_debug("\(self)@end")
    }
    @objc func vcci_viewDidAppear(_ animated: Bool) {
        vcci_swizzle_debug("\(self)@start")
        vcci_viewDidAppear(animated)
        viewDidAppearCount += 1
        vcci_swizzle_debug("\(self)@end")
    }
    @objc func vcci_viewWillDisappear(_ animated: Bool) {
        vcci_swizzle_debug("\(self)@start")
        vcci_viewWillDisappear(animated)
        vcci_swizzle_debug("\(self)@end")
    }
    @objc func vcci_viewDidDisappear(_ animated: Bool) {
        vcci_swizzle_debug("\(self)@start")
        vcci_viewDidDisappear(animated)
        isViewVisible = false
        vcci_swizzle_debug("\(self)@end")
    }
    
}
