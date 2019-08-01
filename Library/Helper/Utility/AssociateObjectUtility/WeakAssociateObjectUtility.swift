//
//  WeakAssociateObjectUtility.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 29/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import ObjectiveC

private final class WeakLifted : NSObject {
    weak var value : NSObject?
    
    init(_ value: NSObject?) {
        self.value = value
    }
}

private func lift(_ x: NSObject?) -> WeakLifted  {
    return WeakLifted(x)
}

func setWeakAssociatedObject<T : NSObject>(_ object: AnyObject, value: T?, associativeKey: UnsafeRawPointer) {
    var v: WeakLifted? = objc_getAssociatedObject(object, associativeKey) as? WeakLifted
    if v == nil {
        v = WeakLifted(value)
        objc_setAssociatedObject(object, associativeKey, v, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    } else {
        v!.value = value
    }
}

func getWeakAssociatedObject<T : NSObject>(_ object: AnyObject, associativeKey: UnsafeRawPointer) -> T? {
    let v: WeakLifted? = objc_getAssociatedObject(object, associativeKey) as? WeakLifted
    return v?.value as? T
}

