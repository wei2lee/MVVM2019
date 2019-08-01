//
//  BaseViewTypeExtensions.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 21/05/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

fileprivate struct BaseViewTypeTypeAssociatedKey {
    static var isParentReady = "isParentReady"
}
extension BaseViewType {
    var isParentReady: BehaviorRelay<Bool> {
        get {
            var ret:BehaviorRelay<Bool>? = getAssociatedObject(self, associativeKey: &BaseViewTypeTypeAssociatedKey.isParentReady)
            if ret == nil {
                ret = BehaviorRelay<Bool>(value: false)
                setAssociatedObject(self,
                                    value: ret,
                                    associativeKey: &BaseViewTypeTypeAssociatedKey.isParentReady,
                                    policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return ret!
        }
        set {
            setAssociatedObject(self,
                                value: newValue,
                                associativeKey: &BaseViewTypeTypeAssociatedKey.isParentReady,
                                policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
