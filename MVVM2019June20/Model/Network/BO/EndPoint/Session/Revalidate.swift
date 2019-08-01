//
//  Revalidate.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension BO.EndPoint {
    class Revalidate: BO.BaseTarget<BO.BaseTokenRequest, BO.ResponseLogin> {
        override var path: String { return "session/revalidate" }
    }
}

