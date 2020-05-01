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
        let retainCount = CFGetRetainCount(self)
        Log.debug("\(self)", userInfo: LogTag.clearup.dictionary)
        for child in children {
            child.dispose()
        }
        if isViewLoaded {
            view.dispose()
        }
        self.disposeBag = DisposeBag()
        let retainCount2 = CFGetRetainCount(self)
        Log.debug("\(self) \(retainCount)->\(retainCount2)", userInfo: LogTag.clearup.dictionary)
    }
}
