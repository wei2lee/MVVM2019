//
//  String+OrEmpty.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 01/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension String {
    var orEmptyReplacement:String {
        if self.count == 0 {
            return String.emptyReplacement
        } else {
            return self
        }
    }
    var orEmpty: String {
        if self.count == 0 {
            return ""
        } else {
            return self
        }
    }
}
