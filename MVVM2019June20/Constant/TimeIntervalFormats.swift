//
//  TimeIntervalFormats.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 31/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwiftDate

public extension TimeInterval.ComponentsFormatterOptions {
    static let hh_mm:TimeInterval.ComponentsFormatterOptions = {
        var ret = TimeInterval.ComponentsFormatterOptions()
        ret.unitsStyle = .abbreviated
        ret.allowedUnits = [.hour, .minute]
        ret.locale = EnumRegion.local.region.locale
        return ret
    }()
    
    static let mm_ss:TimeInterval.ComponentsFormatterOptions = {
        var ret = TimeInterval.ComponentsFormatterOptions()
        ret.unitsStyle = .abbreviated
        ret.allowedUnits = [.minute, .second]
        ret.locale = EnumRegion.local.region.locale
        return ret
    }()
    
    static let mm:TimeInterval.ComponentsFormatterOptions = {
        var ret = TimeInterval.ComponentsFormatterOptions()
        ret.unitsStyle = .abbreviated
        ret.allowedUnits = [.minute]
        ret.locale = EnumRegion.local.region.locale
        return ret
    }()
}
