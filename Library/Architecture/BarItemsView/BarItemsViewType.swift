//
//  NavigationBarItemsViewType.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 08/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

protocol BarItemsViewType: class {
    
    var leftBarItem: BarItem? { set get }
    
    var leftBarItems:[BarItem] { set get }
    
    var rightBarItem: BarItem? { set get }
    
    var rightBarItems:[BarItem] { set get }
    
    func updateRightBarButtons()
    
    func updateLeftBarButtons()
}

