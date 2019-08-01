//
//  NSObject+TypeName.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 02/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension NSObject {
    var typeName: String {
        return String(describing: type(of: self))
    }
    
    static var typeName: String {
        return String(describing: self)
    }
}
