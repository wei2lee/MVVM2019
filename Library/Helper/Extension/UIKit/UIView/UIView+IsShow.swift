//
//  UIView+IsShow.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 04/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

extension UIView {
    var isShow: Bool {
        set { isHidden = !newValue }
        get { return !isHidden }
    }
}

