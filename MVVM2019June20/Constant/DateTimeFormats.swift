//
//  DateFormatConstants.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import SwiftDate

extension DateFormats {
    static let iso8601s = [
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'",
        "yyyy-MM-dd'T'HH:mm:ss",
        "yyyy-MM-dd'T'HH:mm:ss.SSS",
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'",
        "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
    ]
    
    static let iso8601WithMiliZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let iso8601WithoutZ = "yyyy-MM-dd'T'HH:mm:ss"
    static let iso8601WithMili = "yyyy-MM-dd'T'HH:mm:ss.SSS"
   
    static let yyyyMMdd_HHmmss = "yyyyMMdd_HHmmss"
    
    static let yyyy_MMM = "yyyy MMM"
    static let yyyy = "yyyy"
    static let MMM = "MMM"
}

