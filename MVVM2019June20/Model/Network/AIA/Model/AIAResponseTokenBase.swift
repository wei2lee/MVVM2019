//
//  AIAResponseTokenBase.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwiftDate

extension AIA {
    public class ResponseTokenBase : ResponseBase {
        public var tokenExpiryDate:DateInRegion? = nil
    }
}
