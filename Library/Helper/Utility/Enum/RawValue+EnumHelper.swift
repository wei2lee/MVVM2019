//
//  RawValue+EnumHelper.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 13/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension String {
    func `as`<T>(_ of: T.Type) -> T? where T : RawRepresentable, T.RawValue == String {
        return T.init(rawValue: self)
    }
}
extension Int {
    func `as`<T>(_ of: T.Type) -> T? where T : RawRepresentable, T.RawValue == Int {
        return T.init(rawValue: self)
    }
}
