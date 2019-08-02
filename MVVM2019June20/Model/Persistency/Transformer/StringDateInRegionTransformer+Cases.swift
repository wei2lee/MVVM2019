//
//  StringDateInRegionTransformers.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwiftDate

extension StringDateInRegionTransformer {
    public static let iso8601s = StringDateInRegionTransformer(inputRegion: .gmt,
                                                              outputRegion: .local,
                                                              formats: DateFormats.iso8601s)
}
