//
//  CaseInsenstiveWithoutUnsafeStringEnum.swift
//  AIAAgent
//
//  Created by Yee Chuan Lee on 25/10/2018.
//  Copyright © 2018 lee yee chuan. All rights reserved.
//

import Foundation

protocol CaseInsenstiveAlphaNumericsStringEnum:StringEnum {
    
}
extension CaseInsenstiveAlphaNumericsStringEnum {
    
    static func normalize(_ value:String) -> String {
        let unsafeChars = NSCharacterSet.alphanumerics.inverted
        return value.uppercased()
            .components(separatedBy: unsafeChars)
            .joined()
    }
}
