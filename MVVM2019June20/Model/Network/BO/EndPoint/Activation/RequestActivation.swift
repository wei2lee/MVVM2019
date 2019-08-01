//
//  RequestActivation.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension BO.EndPoint {
    class RequestActivation: BO.BaseTarget<BO.RequestRequestActivation, BO.ResponseRequestActivation> {
        override var path: String { return "activation/requestactivation" }
    }
    
}
extension BO {
    class RequestRequestActivation: BO.BaseTokenRequest {
        
    }
    
    class ResponseRequestActivation: BO.BaseResponse {
        
        enum CodingKeys: String, CodingKey {
            case sessionId = "sessionId"
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            sessionId = try? values.decodeIfPresent(String.self, forKey: .sessionId)
            try super.init(from: decoder)
        }
        
        override init() {
            super.init()
        }
        
        var sessionId: String?
    }
    
}

