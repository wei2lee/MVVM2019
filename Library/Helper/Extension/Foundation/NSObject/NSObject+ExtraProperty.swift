//
//  NSObject+ExtraProperty.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 27/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension NSObject {
    fileprivate struct AssociatedKey {
        static var link = "link"
        static var data = "data"
        static var name = "name"
        static var id = "id"
    }
    
    @IBInspectable var aoName:String? {
        get {
            let ret:String? = getAssociatedObject(self, associativeKey: &AssociatedKey.name)
            return ret
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.name, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @IBInspectable var aoLink: String? {
        get {
            let ret:String? = getAssociatedObject(self, associativeKey: &AssociatedKey.link)
            return ret
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.link, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var aoData: AnyObject? {
        get {
            let ret:AnyObject? = getAssociatedObject(self, associativeKey: &AssociatedKey.data)
            return ret
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.data, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @IBInspectable var aoId:String? {
        get {
            let ret:String? = getAssociatedObject(self, associativeKey: &AssociatedKey.id)
            return ret
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.id, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
