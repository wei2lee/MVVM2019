//
//  UIView+RxIsShow.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 04/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base : UIView {
    var isShow: Binder<Bool> {
        return Binder<Bool>(base, binding: { (target, value) in
            target.isShow = value
        })
    }
}
