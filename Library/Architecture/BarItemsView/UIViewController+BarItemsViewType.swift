//
//  UIViewController+NavigationBarItem.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 08/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

extension UIViewController: BarItemsViewType {
    fileprivate struct AssociatedKey {
        static var navigationLeftBarItems = "navigationLeftBarItems"
        static var navigationRightBarItems = "navigationRightBarItems"
    }

    var leftBarItem: BarItem? {
        set {
            if let value = newValue {
                leftBarItems = [value]
            } else {
                leftBarItems = []
            }
        }
        get {
            return leftBarItems.first
        }
    }
    
    var leftBarItems:[BarItem] {
        get {
            let ret:[BarItem]? = getAssociatedObject(self, associativeKey: &AssociatedKey.navigationLeftBarItems)
            return ret ?? []
        }
        
        set {
            for e in newValue {
                e.viewController = self
            }
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.navigationLeftBarItems, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.updateLeftBarButtons()
        }
    }
    
    
    var rightBarItem: BarItem? {
        set {
            if let value = newValue {
                rightBarItems = [value]
            } else {
                rightBarItems = []
            }
        }
        get {
            return rightBarItems.first
        }
    }
    
    var rightBarItems:[BarItem] {
        get {
            let ret:[BarItem]? = getAssociatedObject(self, associativeKey: &AssociatedKey.navigationRightBarItems)
            return ret ?? []
        }
        
        set {
            for e in newValue {
                e.viewController = self
            }
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.navigationRightBarItems, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.updateRightBarButtons()
        }
    }
    
    func updateRightBarButtons() {
        var barButtonItems: [UIBarButtonItem] = []
        for item in self.rightBarItems {
            if let barButtonItem = item.createBarButtonItem() {
                barButtonItems += [barButtonItem]
            }
        }
        self.navigationItem.rightBarButtonItems = barButtonItems
    }
    
    func updateLeftBarButtons() {
        var barButtonItems: [UIBarButtonItem] = []
        for item in self.leftBarItems {
            if let barButtonItem = item.createBarButtonItem() {
                barButtonItems += [barButtonItem]
            }
        }
        self.navigationItem.leftBarButtonItems = barButtonItems
    }
    
    func leftBarButtonItem(_ barItem: BarItem) -> UIBarButtonItem? {
        let base = self
        let index = base.leftBarItems.firstIndex(where: { $0 == barItem })
        if let index = index, let buttonItems = base.navigationItem.leftBarButtonItems {
            if index < buttonItems.count {
                let buttonItem = buttonItems[index]
                return buttonItem
            }
        }
        return nil
    }
    func rightBarButtonItem(_ barItem: BarItem) -> UIBarButtonItem? {
        let base = self
        let index = base.rightBarItems.firstIndex(where: { $0 == barItem })
        if let index = index, let buttonItems = base.navigationItem.rightBarButtonItems {
            if index < buttonItems.count {
                let buttonItem = buttonItems[index]
                return buttonItem
            }
        }
        return nil
    }
}
