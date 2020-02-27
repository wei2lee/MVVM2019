//
//  DateProvider.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 22/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwiftDate

class DateProvider : DateProviderType {
    static let shared = DateProvider()
    var date: Date {
        return Date()
    }
    var now: DateInRegion {
        return DateInRegion(date, region: EnumRegion.local.region)
    }
    
    var yesterday: DateInRegion {
        return now
    }
}
