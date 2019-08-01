//
//  UIViewController+ViewControllerCycleImplType.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 29/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

extension UIViewController: ViewControllerCycleImplType {
    fileprivate struct AssociatedKey {
        static var viewWillAppearCount = "viewWillAppearCount"
        static var viewDidAppearCount = "viewDidAppearCount"
        static var isViewVisible = "isViewVisible"
    }
    
    var viewWillAppearCount:Int {
        get {
            let ret:Int? = getAssociatedObject(self, associativeKey: &AssociatedKey.viewWillAppearCount)
            return ret ?? 0
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.viewWillAppearCount, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var viewDidAppearCount:Int {
        get {
            let ret:Int? = getAssociatedObject(self, associativeKey: &AssociatedKey.viewDidAppearCount)
            return ret ?? 0
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.viewDidAppearCount, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var isViewVisible:Bool {
        get {
            let ret:Bool? = getAssociatedObject(self, associativeKey: &AssociatedKey.isViewVisible)
            return ret ?? false
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.isViewVisible, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
