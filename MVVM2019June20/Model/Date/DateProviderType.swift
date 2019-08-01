//
//  DateProviderType.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 22/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwiftDate

protocol DateProviderType {
    var now: DateInRegion { get }
}
