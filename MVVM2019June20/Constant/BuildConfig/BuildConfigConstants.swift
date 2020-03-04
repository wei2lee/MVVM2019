//
//  BuildConfigConstants.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 22/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

#if ENV_DEV_LOCAL
var BuildConfiguration:EnumBuildConfiguration = .development
#elseif ENV_DEV_STAGING
var BuildConfiguration:EnumBuildConfiguration = .developmentStaging
#elseif ENV_DEV_PRODUCTION
var BuildConfiguration:EnumBuildConfiguration = .developmentProduction
#elseif ENV_STAGING
var BuildConfiguration:EnumBuildConfiguration = .staging
#elseif ENV_STAGING_PENTEST
var BuildConfiguration:EnumBuildConfiguration = .stagingPentest
#elseif ENV_PRODUCTION
var BuildConfiguration:EnumBuildConfiguration = .production
#else
var BuildConfiguration:EnumBuildConfiguration = .development
#endif
