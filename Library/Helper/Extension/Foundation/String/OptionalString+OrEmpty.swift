//
//  String+OrEmpty.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 01/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmptyReplacement : String {
        switch self {
        case .some(let value):
            return value.orEmptyReplacement
        case _:
            return String.emptyReplacement
        }
    }
    var orEmpty : String {
        switch self {
        case .some(let value):
            return value
        case _:
            return ""
        }
    }
}
