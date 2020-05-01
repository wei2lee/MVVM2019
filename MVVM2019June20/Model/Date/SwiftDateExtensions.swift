//
//  SwiftDateExtensions.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 22/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwiftDate

extension Region {
    static var malaysia: Region {
        return EnumRegion.malaysia.region
    }
    static var gmt: Region {
        return EnumRegion.gmt.region
    }
    static var local: Region {
        let buildConfig = DI.resolver.resolve(BuildConfigType.self)!
        return buildConfig.localRegion.region
    }
}

extension DateInRegion {
    var inMalaysia: DateInRegion {
        return DateInRegion(self.date, region: .malaysia)
    }
    var inGMT: DateInRegion {
        return DateInRegion(self.date, region: .gmt)
    }
    var inLocal: DateInRegion {
        return DateInRegion(self.date, region: .local)
    }
    static var now: DateInRegion {
        let now = DI.resolver.resolve(DateProviderType.self)!.now
        return DateInRegion(now.date, region: .local)
    }
}

extension Date {
    var inMalaysia: DateInRegion {
        return DateInRegion(self, region: .malaysia)
    }
    var inGMT: DateInRegion {
        return DateInRegion(self, region: .gmt)
    }
    var inLocal: DateInRegion {
        return DateInRegion(self, region: .local)
    }
    static var now: Date {
        let now = DI.resolver.resolve(DateProviderType.self)!.now
        return now.date
    }
}
