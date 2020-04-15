//
//  NetworkError.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 02/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

enum NetworkError: Error, CustomNSError, CaseIterable {
    case generic
    case noInternetConnection
    case connectionTimeout
    
    //MARK: CustomNSError
    /// The domain of the error.
    public static var errorDomain: String { return "app.network" }
    
    /// The error code within the given domain.
    public var errorCode: Int {
        switch self {
        case .generic: return 999
        case .noInternetConnection: return 900
        case .connectionTimeout: return 950
        }
    }
    
    /// The user-info dictionary.
    public var errorUserInfo: [String : Any] {
        switch self {
        case .generic:
            return [
                NSErrorUserInfoKey.LocalizedTitle: "Network Error",
                NSErrorUserInfoKey.LocalizedDescription: "Network Error"
            ]
        case .noInternetConnection:
            return [
                NSErrorUserInfoKey.LocalizedTitle: "Network Error",
                NSErrorUserInfoKey.LocalizedDescription: "No internet connection"
            ]
        case .connectionTimeout:
            return [
                NSErrorUserInfoKey.LocalizedTitle: "Network Error",
                NSErrorUserInfoKey.LocalizedDescription: "Connection timemout"
            ]
        }
    }
}

