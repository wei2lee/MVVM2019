//
//  CustomBarItem.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 08/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

extension BarItem {
    static func custom(id: String, view: UIView, closure: ((UIViewController)->())? = nil) -> BarItem {
        let ret = CustomBarItem(id: id, view: view)
        ret.closure = closure
        return ret
    }
    
    static func custom(id: String, title: String, closure: ((UIViewController)->())? = nil) -> BarItem {
        let ret = CustomBarItem(id: id, title: title)
        ret.closure = closure
        return ret
    }
}

class CustomBarItem: BarItem {
    let view: UIView?
    let title: String?
    init(id: String, view: UIView) {
        self.view = view
        self.title = nil
        super.init(id: id)
    }
    init(id: String, title: String) {
        self.title = title
        self.view = nil
        super.init(id: id)
    }
    override func createBarButtonItem() -> UIBarButtonItem? {
        if let view = view {
            let item = UIBarButtonItem(customView: view)
            item.target = self
            item.action = #selector(self.performAction(sender:))
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            return item
        } else if let title = title {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(self.performAction(sender:)))
            return item
        } else {
            return nil
        }
    }
}
