//
//  UIViewController+RxDismissWithResultProtocol.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 01/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: DismissWithResultProtocol {
    var onDismissResult: Single<DismissResult> {
        return base.onDismissResult.asSingle()
    }
}
