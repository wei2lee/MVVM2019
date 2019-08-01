//
//  SaveBarItem.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 24/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

extension BarItem {
    static func save(closure: ((UIViewController)->())? = BackBarItem.defaultClosure) -> BarItem {
        let ret = SaveBarItem()
        ret.closure = closure
        return ret
    }
}

class SaveBarItem: BarItem {
    static let defaultId = "save"
    class func defaultClosure(_ vc:UIViewController) {
        
    }
    init() {
        super.init(id: SaveBarItem.defaultId)
    }
    override func createBarButtonItem() -> UIBarButtonItem? {
        let image:UIImage = UIImage()
        let item = UIBarButtonItem(image:image , style: .plain, target: self, action: #selector(self.performAction(sender:)))
        item.tintColor = UIColor.white
        item.imageInsets = .zero
        return item
    }
}
