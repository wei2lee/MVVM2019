//
//  App+SwiftDate.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import SwiftDate

extension AppDelegate {
    func setupSwiftDate() {
        SwiftDate.defaultRegion = EnumRegion.local.region
    }
}
