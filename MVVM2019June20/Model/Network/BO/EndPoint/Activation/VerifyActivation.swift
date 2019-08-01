//
//  VerifyActivation.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension BO.EndPoint {
    class VerifyActivation: BO.BaseTarget<BO.RequestVerifyActivation, BO.ResponseVerifyActivation> {
        override var path: String { return "activation/verifyactivation" }
    }
    
}
extension BO {
    class RequestVerifyActivation: BO.BaseTokenRequest {
        var activationCode: String?
        var sessionId: String?
        
        enum CodingKeys: String, CodingKey {
            case activationCode = "activationCode"
            case sessionId = "sessionId"
        }
        
        override func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: CodingKeys.self)
          try? container.encode(activationCode, forKey: .activationCode)
          try? container.encode(sessionId, forKey: .sessionId)
        }
    }
    
    class ResponseVerifyActivation: BO.BaseResponse {
        
    }
    
}
