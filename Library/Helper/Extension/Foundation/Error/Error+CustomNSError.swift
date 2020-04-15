//
//  Error+CustomNSError.swift
//  MVVM2019June20
//
//  Created by UF-Jacky.Lee on 15/04/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension Error where Self : CustomNSError, Self : CaseIterable {
    init?(error: NSError) {
        guard error.domain == Self.errorDomain else {
            return nil
        }
        for ele in Self.allCases {
            if ele.errorCode == error.code {
                self = ele
                break
            }
        }
        return nil
    }
}
