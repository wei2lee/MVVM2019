//
//  OMDbResponseList.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension OMDb {
    class ResponseList<T> : BaseResponse where T : Codable {
        var search : [T]?
        var totalResults : Int?
        
        fileprivate enum CodingKeys: String, CodingKey {
            case search = "Search"
            case totalResults = "totalResults"
        }
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            search = try values.decodeIfPresent([T].self, forKey: .search)
            totalResults = try values.decode(.totalResults, transformer: StringIntTransformer.shared)
            try super.init(from: decoder)
        }
    }
}
