//
//  AuthServiceType.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 22/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


protocol AuthServiceType {
    func login(username: String, password: String) -> Observable<LoginSession>
    func revalidate(loginSession: LoginSession?, catchErrorJustNext: Bool) -> Observable<Void>
    func logout(loginSession: LoginSession?, catchErrorJustNext: Bool) -> Observable<Void>
}

