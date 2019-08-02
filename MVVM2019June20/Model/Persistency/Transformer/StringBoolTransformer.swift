//
//  StringBoolTransformer.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 02/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import CodableExtensions

class StringBoolTransformer: CodingContainerTransformer {
    static let shared = StringBoolTransformer()
    typealias Input = String
    typealias Output = Bool
    func transform(_ decoded: Input) throws -> Output {
        if decoded.lowercased() == "true" {
            return true
        } else {
            return false
        }
    }
    func transform(_ encoded: Output) throws -> Input {
        return encoded ? "True" : "False"
    }
}
