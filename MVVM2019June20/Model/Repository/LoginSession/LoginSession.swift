//
//  LoginSession.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

struct LoginSession {
    var id: String?
    var userId: String?
    var username: String?
    var token: String?
    
    init(response: BO.ResponseLogin) {
        id = UUID().uuidString
        userId = response.userId
        username = response.username
        token = response.token
    }
    
    init() {
        id = UUID().uuidString
    }
}

