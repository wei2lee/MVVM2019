//
//  CloseBarItem.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 08/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

extension BarItem {
    static func close(closure: ((UIViewController)->())? = CloseBarItem.defaultClosure) -> BarItem {
        let ret = CloseBarItem()
        ret.closure = closure
        return ret
    }
}

class CloseBarItem: BarItem {
    static let defaultId = "close"
    class func defaultClosure(_ vc:UIViewController) {
        vc.closeWithResult()
    }
    init() {
        super.init(id: CloseBarItem.defaultId)
    }
    override func createBarButtonItem() -> UIBarButtonItem? {
        let image:UIImage
        if #available(iOS 13.0, *) {
            image = UIImage(systemName: "xmark")!
        } else {
            image = UIImage()
        }
        let item = UIBarButtonItem(image:image , style: .plain, target: self, action: #selector(self.performAction(sender:)))
        item.imageInsets = .zero
        return item
    }
}
