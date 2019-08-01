//
//  OMDBError.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 02/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension OMDb {
    enum Error: Swift.Error, CustomNSError {
        case response(response: OMDb.BaseResponse)
        case generic
        
        static var errorDomain: String {
            return "app.OMDb"
        }
        
        /// The error code within the given domain.
        var errorCode: Int {
            switch self {
            case .response(_):
                return 100
            case .generic:
                return 9999
            }
        }
        
        /// The user-info dictionary.
        var errorUserInfo: [String : Any] {
            switch self {
            case .response(let response):
                return [NSErrorUserInfoKey.LocalizedTitle: "Server Error",
                        NSErrorUserInfoKey.LocalizedDescription: response.error.orEmpty]
            case .generic:
                return [NSErrorUserInfoKey.LocalizedTitle: "Server Error",
                        NSErrorUserInfoKey.LocalizedDescription: "Server Error"]
            }
        }
    }
}
