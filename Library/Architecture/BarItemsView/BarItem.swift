//
//  NavigationBarItem.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 08/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

class BarItem: Equatable {
    var id: String
    
    var closure: ((UIViewController)->())? = nil
    
    weak var viewController: UIViewController? = nil
    
    static func == (lhs: BarItem, rhs: BarItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(id: String) {
        self.id = id
    }
    
    func createBarButtonItem() -> UIBarButtonItem? {
        return nil
    }
    
    @objc func performAction(sender: Any?) {
        if let viewController = viewController {
            closure?(viewController)
        }
    }
}
