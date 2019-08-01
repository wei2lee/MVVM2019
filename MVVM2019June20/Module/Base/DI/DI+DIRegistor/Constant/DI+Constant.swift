//
//  DI+Constants.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension DI {
    struct Constant : DIRegistor {
        static func register() {
            //MARK: BuildConfig
            DI.container.register(BuildConfigType.self) { r in
                switch BuildConfiguration {
                case .development:
                    return DevelopmentBuildConfig()
                case .developmentStaging:
                    return DevelopmentBuildConfig()
                case .developmentProduction:
                    return DevelopmentBuildConfig()
                case .staging:
                    return StagingBuildConfig()
                case .stagingPentesting:
                    return StagingBuildConfig()
                case .production:
                    return ProductionBuildConfig()
                }
            }
        }
    }
}
