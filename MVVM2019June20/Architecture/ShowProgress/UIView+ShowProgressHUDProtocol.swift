//
//  UIView+ShowProgressHUDProtocol.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 27/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIView : ShowProgressHUDProtocol {
    fileprivate struct AssociatedKey {
        static var mbProgressHUD = "mbProgressHUD"
    }
    
    var mbProgressHUD: MBProgressHUD? {
        get {
            let ret:MBProgressHUD? = getAssociatedObject(self, associativeKey: &AssociatedKey.mbProgressHUD)
            return ret
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.mbProgressHUD, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showProgressHUD() {
        let impl = ShowProgressHUDProtocolImpl(base: self)
        return impl.showProgressHUD()
    }
    
    func showProgressHUD(label:String) {
        let impl = ShowProgressHUDProtocolImpl(base: self)
        return impl.showProgressHUD(label:label)
    }
    
    func hideProgressHUD() {
        let impl = ShowProgressHUDProtocolImpl(base: self)
        return impl.hideProgressHUD()
    }
}
