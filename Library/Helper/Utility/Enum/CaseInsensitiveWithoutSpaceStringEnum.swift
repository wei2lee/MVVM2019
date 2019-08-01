//
//  CaseInsensitiveWithoutSpaceStringEnum.swift
//  AIAAgent
//
//  Created by Yee Chuan Lee on 24/10/2018.
//  Copyright © 2018 lee yee chuan. All rights reserved.
//

import Foundation

protocol CaseInsensitiveWithoutSpaceStringEnum:StringEnum {
    
}
extension CaseInsensitiveWithoutSpaceStringEnum {
    
    static func normalize(_ value:String) -> String {
        return value
            .replacingOccurrences(of: " ", with: "")
            .uppercased()
    }
}
