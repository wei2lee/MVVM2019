//
//  DoneBarItem.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 15/05/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

extension BarItem {
    static func done(closure: ((UIViewController)->())? = DoneBarItem.defaultClosure) -> BarItem {
        let ret = DoneBarItem()
        ret.closure = closure
        return ret
    }
}

class DoneBarItem: BarItem {
    static let defaultId = "done"
    class func defaultClosure(_ vc:UIViewController) {

    }
    init() {
        super.init(id: DoneBarItem.defaultId)
    }
    override func createBarButtonItem() -> UIBarButtonItem? {
        let title = "Done"
        let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(self.performAction(sender:)))
        return item
    }
}
