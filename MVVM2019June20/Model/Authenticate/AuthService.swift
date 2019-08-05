//
//  AuthService.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift
import FCUUID

class AuthService : AuthServiceType {
    //Dependency
    @Injected fileprivate var loginSessionRepository: LoginSessionRepositoryType
    @Injected fileprivate var provider: BO.Provider
    //static
    public static let shared = AuthService()
    //
    public func login(username: String, password: String) -> Observable<LoginSession> {
        let input = BO.RequestLogin()
        input.username = username
        input.password = password
        input.deviceId = FCUUID.uuidForDevice()
        let api = BO.EndPoint.Login(input: input).request(provider: provider)
        return api
            .map { response -> EnumLoginComparision in
                let newLoginSession = LoginSession(response: response)
                let lastLoginSession = self.loginSessionRepository.currentLoginSession
                
                if let lastLoginSession = lastLoginSession {
                    if newLoginSession.userId != lastLoginSession.userId {
                        return .diffUser(current: newLoginSession, previous: lastLoginSession)
                    } else {
                        return .sameUser(current: newLoginSession)
                    }
                } else {
                    return .newUser(current: newLoginSession)
                }
            }
            .flatMap({ loginComparision -> Observable<EnumLoginComparision> in
                switch loginComparision {
                case .diffUser(_, let previous):
                    return self.logout(loginSession: previous,
                                       catchErrorJustNext: true)
                        .map { _ in loginComparision }
                default:
                    return .just(loginComparision)
                }
            })
            .flatMap({ [weak self] loginComparision -> Observable<LoginSession> in
                guard let self = self else { return .empty() }
                //side effect
                switch loginComparision {
                case .sameUser(let current):
                    self.createLoginSession(loginSession: current, setAsCurrent: true)
                case .diffUser(let current, _):
                    self.createLoginSession(loginSession: current, setAsCurrent: true)
                    self.createUserRepository(userId: current.userId ?? "")
                case .newUser(let current):
                    self.createLoginSession(loginSession: current, setAsCurrent: true)
                }
                return .just(loginComparision.current)
        })
    }
    
    public func revalidate(loginSession: LoginSession? = nil, catchErrorJustNext: Bool = true) -> Observable<Void> {
        let loginSession_ = loginSession ?? loginSessionRepository.currentLoginSession
        guard let loginSession = loginSession_ else {
            return .empty()
        }
        let input = BO.BaseTokenRequest(loginSession: loginSession)
        let api = BO.EndPoint.Revalidate(input: input).request(provider: provider)
        return api.do(onNext: { response in
            let current = LoginSession(response: response)
            self.createLoginSession(loginSession: current, setAsCurrent: true)
        }, onError: { _ in
            
        }).asVoid().catchError({ error -> Observable<()> in
            if catchErrorJustNext {
                return .just(())
            } else {
                return .error(error)
            }
        })
    }
    
    public func logout(loginSession: LoginSession? = nil, catchErrorJustNext: Bool = true) -> Observable<Void> {
        let loginSession_ = loginSession ?? loginSessionRepository.currentLoginSession
        guard let loginSession = loginSession_ else {
            return .empty()
        }
        let input = BO.BaseTokenRequest(loginSession: loginSession)
        let api = BO.EndPoint.Logout(input: input).request(provider: provider)
        return api.asVoid().catchError({ error -> Observable<()> in
            if catchErrorJustNext {
                return .just(())
            } else {
                return .error(error)
            }
        }).do(onNext: { _ in
            if self.loginSessionRepository.currentLoginSession?.id == loginSession.id {
                self.loginSessionRepository.currentLoginSession = nil
            }
            self.destroyLoginSession(loginSession: loginSession)
            self.destroyUserRepository(userId: loginSession.userId ?? "")
        }, onError: { _ in
            if self.loginSessionRepository.currentLoginSession?.id == loginSession.id {
                self.loginSessionRepository.currentLoginSession = nil
            }
            self.destroyLoginSession(loginSession: loginSession)
            self.destroyUserRepository(userId: loginSession.userId ?? "")
        })
    }
    
    fileprivate func createLoginSession(loginSession: LoginSession, setAsCurrent: Bool) {
        //create or update LoginSession
        loginSessionRepository.add(loginSession)
        if setAsCurrent {
            self.loginSessionRepository.currentLoginSession = loginSession
        }
    }
    
    fileprivate func destroyLoginSession(loginSession: LoginSession) {
        //delete LoginSession
        loginSessionRepository.delete(loginSession)
    }
    
    fileprivate func createUserRepository(userId: String) {
        //create User dependant CacheService
        //create User dependant Repository
    }
    
    fileprivate func destroyUserRepository(userId: String) {
        //cleanup User dependant CacheService
        //cleanup User dependant Repository
    }
}

