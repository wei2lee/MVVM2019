//
//  Error+ConvertToNSError.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 01/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension Error {
    var error: NSError {
        return self as NSError
    }
}

//static func == (lhs: Error, rhs: NSError) -> Bool {
//    return (lhs as NSError) == rhs
//}
//static func == (lhs: NSError, rhs: Error) -> Bool {
//    return lhs == (rhs as NSError)
//}
