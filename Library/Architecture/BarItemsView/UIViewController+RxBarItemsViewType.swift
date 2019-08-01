//
//  NavigationBarItem+Rx.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 08/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    func leftBarButtonItem(_ barItem: BarItem) -> Driver<Void> {
        let index = base.leftBarItems.firstIndex(where: { $0 == barItem })
        if let index = index, let buttonItems = base.navigationItem.leftBarButtonItems {
            if index < buttonItems.count {
                let buttonItem = buttonItems[index]
                return buttonItem.rx.tap.asDriver()
            }
        }
        return .empty()
    }
    func rightBarButtonItem(_ barItem: BarItem) -> Driver<Void> {
        let index = base.rightBarItems.firstIndex(where: { $0 == barItem })
        if let index = index, let buttonItems = base.navigationItem.rightBarButtonItems {
            if index < buttonItems.count {
                let buttonItem = buttonItems[index]
                return buttonItem.rx.tap.asDriver()
            }
        }
        return .empty()
    }
}
