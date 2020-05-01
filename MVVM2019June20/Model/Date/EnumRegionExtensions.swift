//
//  EnumRegionExtensions.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 22/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwiftDate

extension EnumRegion {
    var now: DateInRegion {
        let dateProvider = DI.resolver.resolve(DateProviderType.self)!
        return DateInRegion(dateProvider.now.date, region: self.region)
    }
    static var local: EnumRegion {
        let buildConfig = DI.resolver.resolve(BuildConfigType.self)!
        return buildConfig.localRegion
    }
}

