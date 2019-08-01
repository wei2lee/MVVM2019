//
//  Login.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import RxCocoa

extension BO.EndPoint {
    class Login: BO.BaseTarget<BO.RequestLogin, BO.ResponseLogin> {
        override var path: String { return "session/login" }
    }
}
extension BO {
    class RequestLogin : BaseRequest {
        var deviceId: String?
        var password: String?
        var username: String?
        
        enum CodingKeys: String, CodingKey {
            case deviceId = "deviceId"
            case password = "password"
            case username = "username"
        }
        
        override func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: CodingKeys.self)
          try? container.encode(deviceId, forKey: .deviceId)
          try? container.encode(password, forKey: .password)
          try? container.encode(username, forKey: .username)
        }
    }
    
    class ResponseLogin : BaseResponse {
        var userId: String?
        var username: String?
        var token: String?
        
        enum CodingKeys: String, CodingKey {
            case userId = "userId"
            case username = "username"
            case token = "token"
        }
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            userId = try? values.decodeIfPresent(String.self, forKey: .userId)
            username = try? values.decodeIfPresent(String.self, forKey: .username)
            token = try? values.decodeIfPresent(String.self, forKey: .token)
            try super.init(from: decoder)
        }
        
        override init() {
            super.init()
        }
    }
}
