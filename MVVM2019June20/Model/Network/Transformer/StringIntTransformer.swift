//
//  StringIntTransformer.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 03/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import CodableExtensions
import Moya

class StringIntTransformer: CodingContainerTransformer {
    static let shared = StringIntTransformer()
    typealias Input = String
    typealias Output = Int
    func transform(_ decoded: Input) throws -> Output {
        if let ret = Int(decoded) {
            return ret
        } else {
            let e = NSError(domain: "app.decoding",
                            code: 0,
                            localizedTitle: "",
                            localizedDescription: "StringIntTransformer")
            throw MoyaError.encodableMapping(e)
        }
    }
    func transform(_ encoded: Output) throws -> Input {
        return encoded.string
    }
}

