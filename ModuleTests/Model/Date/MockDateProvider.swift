//
//  DateProvider.swift
//  ModuleTests
//
//  Created by Yee Chuan Lee on 05/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwiftDate
@testable import MVVM2019June20

class MockDateProvider: DateProviderType {
     lazy var now: DateInRegion = EnumRegion.malaysia.now
}
