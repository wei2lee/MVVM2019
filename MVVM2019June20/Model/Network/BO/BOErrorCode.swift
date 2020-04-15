//
//  BOErrorCode.swift
//  MVVM2019June20
//
//  Created by UF-Jacky.Lee on 16/04/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension BO {
    enum ErrorCode: String, CaseIterable {
        case invalidToken = "11"
        case serverDown = "22"
        case generic = "99"
    }
}
