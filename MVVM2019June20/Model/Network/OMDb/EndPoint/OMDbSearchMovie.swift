//
//  OMDbSearchMovie.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension OMDb.EndPoint {
    class SearchMovie: OMDb.BaseTarget<OMDb.RequestSearchMovie, OMDb.ResponseSearchMovie> {
    }
}
extension OMDb {
    struct RequestSearchMovie : Codable {
        var s: String = "toy story"
        var type: OMDb.EnumResultReturnType?
        var y: String?
        var r: String?
        var page: Int?
        var callback: OMDb.EnumDataReturnType?
        var v: String?
        
        enum CodingKeys: String, CodingKey {
            case s = "s"
            case type = "type"
            case y = "y"
            case r = "r"
            case page = "page"
            case callback = "callback"
            case v = "v"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            s = try values.decodeIfPresent(String.self, forKey: .s) ?? ""
            type = try values.decodeIfPresent(OMDb.EnumResultReturnType.self, forKey: .type)
            y = try values.decodeIfPresent(String.self, forKey: .y)
            r = try values.decodeIfPresent(String.self, forKey: .r)
            page = try values.decodeIfPresent(Int.self, forKey: .page) ?? 1
            callback = try values.decodeIfPresent(OMDb.EnumDataReturnType.self, forKey: .callback)
            v = try values.decodeIfPresent(String.self, forKey: .v)
        }
        
        init() { }
    }
}

extension OMDb {
    typealias ResponseSearchMovie = OMDb.ResponseList<OMDb.MovieSearchResult>
}
