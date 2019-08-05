//
//  LoginSessionRepository.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class LoginSessionRepository : LoginSessionRepositoryType {
    static let shared = LoginSessionRepository()
    fileprivate var values: [LoginSession] = []
    fileprivate let currentLoginSessionRelay = BehaviorRelay<LoginSession?>(value: nil)
    var previousLoginSession: LoginSession? = nil
    var currentLoginSession: LoginSession? {
        set {
            currentLoginSessionRelay.accept(newValue)
        }
        get {
            return currentLoginSessionRelay.value
        }
    }
    var lastLoginSession: LoginSession? {
        return currentLoginSession ?? previousLoginSession
    }
    func add(_ value: LoginSession) {
        //TODO
        values += [value]
    }
    func delete(_ value: LoginSession) {
        //TODO
        values = values.filter { $0.id == value.id }
    }
}
extension Reactive where Base : LoginSessionRepository {
    var currentLoginSession : Observable<LoginSession?> {
        return base.currentLoginSessionRelay.asObservable()
    }
}

