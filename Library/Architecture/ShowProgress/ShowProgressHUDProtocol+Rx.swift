//
//  ShowProgressHUD+Rx.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 02/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: NSObject, Base: ShowProgressHUDProtocol {
    var isShowProgressHUD: Binder<Bool> {
        return Binder<Bool>(self.base) { (control: ShowProgressHUDProtocol, isShowProgressHUD: Bool) in
            if isShowProgressHUD {
                self.base.showProgressHUD()
            } else {
                self.base.hideProgressHUD()
            }
        }
    }
}
