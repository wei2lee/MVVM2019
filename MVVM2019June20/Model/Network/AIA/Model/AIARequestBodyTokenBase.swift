//
//  AIARequestBodyTokenBase.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension AIA {
    public class RequestBodyTokenBase : AIA.RequestBodyBase {
        public var token:String = ""
        convenience init(token:String) {
            self.init();
            self.token = token
        }
    }
}
