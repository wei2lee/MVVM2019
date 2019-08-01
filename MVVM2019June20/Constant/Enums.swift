//
//  Constants.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwiftDate

enum EnumBuildConfiguration:String {
    case development
    case developmentStaging
    case developmentProduction
    case staging
    case stagingPentesting
    case production
}

public enum EnumLocale {
    case usEnglish
    var locale: Locale {
        switch self {
        case .usEnglish: return Locale(identifier: "en_US_POSIX")
        }
    }
}

public enum EnumTimeZone {
    case malaysia
    case gmt
    
    var timeZone: TimeZone {
        switch self {
        case .malaysia: return TimeZone(abbreviation: "GMT+8:00")!
        case .gmt: return TimeZone(abbreviation: "GMT+0:00")!
        }
    }
}

public enum EnumRegion {
    case malaysia
    case gmt

    private static let malaysiaRegion = Region(calendar: Calendars.gregorian.toCalendar(),
                                               zone: EnumTimeZone.malaysia.timeZone,
                                               locale: EnumLocale.usEnglish.locale)
    private static let gmtRegion = Region(calendar: Calendars.gregorian.toCalendar(),
                                          zone: EnumTimeZone.gmt.timeZone,
                                          locale: EnumLocale.usEnglish.locale)
    
    var region:Region {
        switch self {
        case .malaysia:
            return EnumRegion.malaysiaRegion
        case .gmt:
            return EnumRegion.gmtRegion
        }
    }
}
