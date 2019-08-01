//
//  DIModelRegistor.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 22/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DI {
    struct Model : DIRegistor {
        static func register() {
            //MARK: Authenticate
            DI.container.register(AuthServiceType.self) { r -> AuthServiceType in
                return AuthService()
            }.inObjectScope(.container)
            //MARK: Date
            DI.container.register(DateProviderType.self) { r -> DateProviderType in
                return DateProvider()
            }.inObjectScope(.container)
            //MARK: Network
            DI.container.register(OMDb.Provider.self) { r -> OMDb.Provider in
                return OMDb.Provider()
            }.inObjectScope(.container)
            DI.container.register(BO.Provider.self) { r -> BO.Provider in
                return BO.MockProvider()
            }.inObjectScope(.container)
            //MARK: Persistency
            DI.container.register(UserDefaults.self) { r -> UserDefaults in
                return SwiftyUserDefaults.Defaults
            }.inObjectScope(.container)
            //MARK: Repository
            DI.container.register(LoginSessionRepositoryType.self) { r -> LoginSessionRepositoryType in
                return LoginSessionRepository()
            }.inObjectScope(.container)
            //MARK: Validation
            DI.container.register(LoginFormValidationServiceType.self) { r -> LoginFormValidationServiceType in
                return LoginFormValidationService()
            }.inObjectScope(.container)
        }
    }
}
