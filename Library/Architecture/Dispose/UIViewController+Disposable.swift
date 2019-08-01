//
//  UIViewController+Disposable.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 29/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@objc extension UIViewController: Disposable {
    @objc public func dispose() {
        //Log.debug("\(self)@UIViewController.dispose")
        for child in children {
            child.dispose()
        }
        if isViewLoaded {
            view.dispose()
        }
        self.disposeBag = DisposeBag()
    }
}
