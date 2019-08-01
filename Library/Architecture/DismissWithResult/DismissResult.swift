//
//  DismissResult.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 08/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

class DismissResult: NSObject {
    var result: Any?
    var identifier: Any?
    
    init(result: Any?, identifier: Any?) {
        self.result = result
        self.identifier = identifier
    }
    
    static var none: DismissResult {
        return DismissResult(result: nil, identifier: nil)
    }
}
