//
//  CaseInsensitiveStringEnum.swift
//  AIAAgent
//
//  Created by Yee Chuan Lee on 24/10/2018.
//  Copyright © 2018 lee yee chuan. All rights reserved.
//

import Foundation

protocol CaseInsensitiveStringEnum:StringEnum {
    
}
extension CaseInsensitiveStringEnum {
    
    static func normalize(_ value:String) -> String {
        return value
            .uppercased()
    }
}

