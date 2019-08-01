//
//  String+IsNilOrEmpty.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 01/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension String {
    var isNilOrEmpty:Bool {
        if self.count == 0 {
            return true
        } else {
            return false
        }
    }
}
