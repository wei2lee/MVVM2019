//
//  BOBaseTokenRequest.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import CodableExtensions
import SwiftDate

extension BO {
    class BaseTokenRequest : BaseRequest {
        var token:String? = nil
        
        override init() {
            token = LoginSession.current?.token
        }
        
        init(loginSession: LoginSession) {
            token = loginSession.token
        }
        
        fileprivate enum CodingKeys: String, CodingKey {
            case token = "token"
        }
        
        override func encode(to encoder: Encoder) throws {
            try super.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try? container.encode(token, forKey: .token)
        }
    }
}

