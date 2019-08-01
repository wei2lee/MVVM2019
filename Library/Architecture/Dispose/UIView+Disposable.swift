//
//  UIView+Disposable.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 01/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@objc extension UIView: Disposable {
    @objc public func dispose() {
        //Log.debug("\(self)@UIViewController.dispose")
        for subview in subviews {
            subview.dispose()
        }
        self.disposeBag = DisposeBag()
    }
}
