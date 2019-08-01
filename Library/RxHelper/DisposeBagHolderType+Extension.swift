//
//  DisposeBagHolderType+Extension.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 01/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift

fileprivate struct AssociatedKey {
    static var disposeBag = "disposeBag"
}
extension DisposeBagHolderType {
    
    var disposeBag:DisposeBag {
        get {
            var ret:DisposeBag? = getAssociatedObject(self, associativeKey: &AssociatedKey.disposeBag)
            if ret == nil {
                ret = DisposeBag()
                setAssociatedObject(self, value: ret, associativeKey: &AssociatedKey.disposeBag)
            }
            return ret!
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.disposeBag)
        }
    }
}

extension Disposable where Self: DisposeBagHolderType  {
    func dispose() {
        disposeBag = DisposeBag()
    }
}
