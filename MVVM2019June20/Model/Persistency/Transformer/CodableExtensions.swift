//
//  CodableExtensions.swift
//  MVVM2019June20
//
//  Created by UF-Jacky.Lee on 13/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation
import CodableExtensions

public extension KeyedEncodingContainer {

    mutating func encodeIfPresent<Transformer: EncodingContainerTransformer>(_ value: Transformer.Output?,
                                                                    forKey key: KeyedEncodingContainer.Key,
                                                                    transformer: Transformer) throws where Transformer.Input : Encodable {
        if let value = value {
            let transformed: Transformer.Input = try transformer.transform(value)
            try self.encode(transformed, forKey: key)
        } else {
            let transformed: Transformer.Input? = nil
            try self.encodeIfPresent(transformed, forKey: key)
        }
    }
}
