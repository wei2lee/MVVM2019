//
//  BOError+Response.swift
//  MVVM2019June20
//
//  Created by UF-Jacky.Lee on 16/04/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension BO.Error {
    init?(response: BO.BaseResponse) {
        switch response.errorCode {
        case BO.ErrorCode.invalidToken.rawValue:
            self = .invalidToken(response: response)
        case BO.ErrorCode.serverDown.rawValue:
            self = .serverDown(response: response)
        case BO.ErrorCode.generic.rawValue:
            self = .response(response: response)
        default:
            return nil
        }
    }
}
