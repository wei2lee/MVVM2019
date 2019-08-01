//
//  OMDbGetMovie.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension OMDb.EndPoint {
    class GetMovie: OMDb.BaseTarget<OMDb.RequestGetMovie, OMDb.Movie> {
    }
}
extension OMDb {
    struct RequestGetMovie {
        var i: String?
        var t: String?
        var type: OMDb.EnumResultReturnType?
        var y: String?
        var plot: OMDb.EnumPlotType?
        var r: String?
        var callback: OMDb.EnumDataReturnType?
        var v: String?
    }
}
