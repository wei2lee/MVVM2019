//
//  RequestActivationFormValidationError.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 31/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

enum RequestActivationFormValidationError: Swift.Error, CustomNSError, CaseIterable {
    case requestActivationNotExpired
    
    static var errorDomain: String {
        return "app.RequestActivationFormValidationError"
    }
    
    /// The error code within the given domain.
    var errorCode: Int {
        switch self {
        case .requestActivationNotExpired:
            return 100
        }
    }
    
    /// The user-info dictionary.
    var errorUserInfo: [String : Any] {
        switch self {
        case .requestActivationNotExpired:
            return [NSErrorUserInfoKey.LocalizedDescription: "Request activation not expired. Try again later."]
        }
    }
}


