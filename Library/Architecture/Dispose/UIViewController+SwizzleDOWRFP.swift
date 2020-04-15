//
//  UIViewController+SwizzleDOWRFP.swift
//  ALPACodePattern
//
//  Created by Yee Chuan Lee on 29/11/2019.
//  Copyright © 2019 lee yee chuan. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController {
    public static func dowfrop_swizzle() {
        
        func swizzle_removeFromParent() {
            let originalSelector = #selector(removeFromParent)
            let swizzledSelector = #selector(dowfrop_removeFromParent)
            swizzling(UIViewController.self, originalSelector, swizzledSelector)
        }
        
        func swizzle_willMove() {
            let originalSelector = #selector(willMove(toParent:))
            let swizzledSelector = #selector(dowfrop_willMove(toParent:))
            swizzling(UIViewController.self, originalSelector, swizzledSelector)
        }
        
        func swizzle_viewWillDisappear() {
            let originalSelector = #selector(viewWillDisappear(_:))
            let swizzledSelector = #selector(dowfrop_viewWillDisappear(_:))
            swizzling(UIViewController.self, originalSelector, swizzledSelector)
        }
        
        swizzle_removeFromParent()
        swizzle_willMove()
        swizzle_viewWillDisappear()
    }
    
    @objc open func dowfrop_viewWillDisappear(_ animated: Bool) {
        dowfrop_viewWillDisappear(animated)
        if isBeingDismissed {
            self.dispose()
        }
    }
    
    @objc open func dowfrop_removeFromParent() {
        dowfrop_removeFromParent()
        //DI.log.debug("\(self)")
    }
    
    @objc open func dowfrop_willMove(toParent parent: UIViewController?) {
        dowfrop_willMove(toParent: parent)
        if disposeOnWillRemoveFromParent {
            if parent == nil {
                //DI.log.debug("dispose**:\(self)")
                self.dispose()
            }
        } else {
            if parent == nil {
                //DI.log.debug("disposeOnWillRemoveFromParent = false, not disposing **:\(self)")
            }
        }
    }
}

