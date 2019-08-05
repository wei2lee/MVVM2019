//
//  BaseViewModel.swift
//  ModuleTests
//
//  Created by Yee Chuan Lee on 05/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
@testable import MVVM2019June20

extension BaseViewModel {
    static func setupBaseViewModelDI() {
        DI.container.register(BuildConfigType.self, factory: { r -> BuildConfigType in
            return DevelopmentBuildConfig()
        }).inObjectScope(.container)
        
        DI.container.register(UserDefaults.self, factory: { r -> UserDefaults in
            return UserDefaults.standard
        }).inObjectScope(.container)
        
        DI.container.register(DateProviderType.self, factory: { r -> DateProviderType in
            return DateProvider()
        }).inObjectScope(.container)
    }
}
