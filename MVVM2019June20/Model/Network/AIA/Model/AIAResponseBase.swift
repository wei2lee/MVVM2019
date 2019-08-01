//
//  AIAResponseBase.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension AIA {
    public class ResponseBase : Codable {
        public var errorCode:String? = nil
        public var errorHeader:String? = nil
        public var errorDescription:String? = nil
    }
}
