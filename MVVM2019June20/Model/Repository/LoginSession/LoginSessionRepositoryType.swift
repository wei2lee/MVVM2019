//
//  LoginSessionRepositoryType.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 22/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation


extension LoginSession {
    static var current: LoginSession? {
        return DI.resolver.resolve(LoginSessionRepositoryType.self)!.currentLoginSession
    }
}

protocol LoginSessionRepositoryType {
    var previousLoginSession: LoginSession? { set get }
    var currentLoginSession: LoginSession? { set get }
    var lastLoginSession: LoginSession? { get }
    func add(_ value: LoginSession)
    func delete(_ value: LoginSession)
}
