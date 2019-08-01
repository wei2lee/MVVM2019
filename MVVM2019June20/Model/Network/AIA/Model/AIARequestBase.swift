//
//  AIARequestBase.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

protocol AIARequestBaseType {
    associatedtype Body
}

extension AIA {
    public class RequestBase<T : AIA.RequestBodyBase> : AIARequestBaseType, Codable {
        typealias Body = T
        public var reqBody:T!
        public init(reqBody:T) {
            self.reqBody = reqBody
        }
    }
}
