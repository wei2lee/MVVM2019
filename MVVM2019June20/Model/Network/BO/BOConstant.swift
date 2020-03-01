//
//  BOConstants.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 02/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension BO {
    enum HTTPRequestHeaderKey: String {
        case sig
        case timestamp
    }
    enum HTTPResponseHeaderKey: String {
        case sig
        case timestamp
    }
    enum EnumEnvironment: String, Encodable {
        case staging
        case production
    }
    enum EnumPlatform: String, Encodable {
        case ios
        case android
    }
}
