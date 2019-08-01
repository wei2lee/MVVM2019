//
//  AIARequestLogin.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension AIA {
    typealias RequestLogin = AIA.RequestBase<AIA.RequestBodyLogin>

    public class RequestBodyLogin : AIA.RequestBodyBase {
        public var userId:String? = nil
        public var password:String? = nil
        public var deviceId:String? = nil
        public var token:String? = nil
        public var revalidationToken:String? = nil
        
        convenience public init(userId:String, password:String, deviceId:String) {
            self.init()
            self.userId = userId
            self.password = password
            self.deviceId = deviceId
        }
        convenience public init(token:String, revalidationToken:String) {
            self.init()
            self.token = token
            self.revalidationToken = revalidationToken
        }
    }
}
