//
//  OMDbConstant.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension OMDb {
    enum EnumResultReturnType : String, Codable {
        case movie = "movie"
        case series = "series"
        case episode = "episode"
    }
    enum EnumPlotType : String {
        case short = "short"
        case full = "full"
    }
    enum EnumDataReturnType : String, Codable {
        case json = "json"
        case xml = "xml"
    }
}
