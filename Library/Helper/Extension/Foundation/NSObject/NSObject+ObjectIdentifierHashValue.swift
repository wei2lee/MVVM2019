//
//  NSObject+ObjectIdentifierHashValue.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 27/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension NSObject {
    var objectIdentifierHashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}
