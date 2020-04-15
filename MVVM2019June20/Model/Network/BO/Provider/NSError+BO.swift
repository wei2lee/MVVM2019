//
//  NSError+BO.swift
//  MVVM2019June20
//
//  Created by UF-Jacky.Lee on 15/04/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension NSError {
    var boResponse:BO.BaseResponse? {
        return self.underlyingKey(key: NSErrorUserInfoKey.ApiResponseObject)
    }
}

