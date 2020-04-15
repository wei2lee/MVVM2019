//
//  BOError.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension BO {
    enum Error: Swift.Error, CustomNSError {
        case response(response: BO.BaseResponse)
        case invalidSignature
        case generic
        
        static var errorDomain: String {
            return "app.BO"
        }
        
        /// The error code within the given domain.
        var errorCode: Int {
            switch self {
            case .response(_):
                return 100
            case .invalidSignature:
                return 8000
            case .generic:
                return 9999
            }
        }
        
        /// The user-info dictionary.
        var errorUserInfo: [String : Any] {
            switch self {
            case .response(let response):
                return [NSErrorUserInfoKey.LocalizedTitle: response.errorHeader ?? "Server Error",
                        NSErrorUserInfoKey.LocalizedDescription: response.errorDescription ?? "Server Error",
                        NSErrorUserInfoKey.ApiResponseObject: response]
            case .invalidSignature:
                return [NSErrorUserInfoKey.LocalizedTitle: "Server Error",
                        NSErrorUserInfoKey.LocalizedDescription: "Invalid Response Signature"]
            case .generic:
                return [NSErrorUserInfoKey.LocalizedTitle: "Server Error",
                        NSErrorUserInfoKey.LocalizedDescription: "Server Error"]
            }
        }
        
        init?(error: NSError) {
            guard error.domain == type(of: self).errorDomain else {
                return nil
            }
            switch error.code {
            case 100:
                if let apiResponseObject = error.apiResponseObject as? BO.BaseResponse {
                    self = .response(response: apiResponseObject)
                } else {
                    return nil
                }
            case 8000:
                self = .invalidSignature
            case 9999:
                self = .generic
            default:
                return nil
            }
            
        }
    }
}

