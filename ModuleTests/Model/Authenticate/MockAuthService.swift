//
//  MockAuthService.swift
//  ModuleTests
//
//  Created by Yee Chuan Lee on 05/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
@testable import MVVM2019June20

class MockAuthService : AuthServiceType {
    func login(username: String, password: String) -> Observable<LoginSession> {
        if username == "A" && password == "a" {
            let response = BO.ResponseLogin()
            let ret = LoginSession(response: response)
            return .just(ret)
        } else {
            let response = BO.BaseResponse()
            return .error(BO.Error.response(response: response))
        }
    }
    
    func revalidate(loginSession: LoginSession?, catchErrorJustNext: Bool) -> Observable<Void> {
        return .just(())
    }
    
    func logout(loginSession: LoginSession?, catchErrorJustNext: Bool) -> Observable<Void> {
        return .just(())
    }
}

class MockNoInternetAuthService : AuthServiceType {
    func login(username: String, password: String) -> Observable<LoginSession> {
        return .error(NetworkError.noInternetConnection.error)
    }
    
    func revalidate(loginSession: LoginSession?, catchErrorJustNext: Bool) -> Observable<Void> {
        return .error(NetworkError.noInternetConnection.error)
    }
    
    func logout(loginSession: LoginSession?, catchErrorJustNext: Bool) -> Observable<Void> {
        return .error(NetworkError.noInternetConnection.error)
    }
}

class MockFailAuthService : AuthServiceType {
    func login(username: String, password: String) -> Observable<LoginSession> {
        return .error(BO.Error.generic.error)
    }
    
    func revalidate(loginSession: LoginSession?, catchErrorJustNext: Bool) -> Observable<Void> {
        return .error(BO.Error.generic.error)
    }
    
    func logout(loginSession: LoginSession?, catchErrorJustNext: Bool) -> Observable<Void> {
        return .error(BO.Error.generic.error)
    }
}
