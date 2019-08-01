//
//  OMDbRating.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension OMDb {
    struct Rating : Codable {
        let source : String?
        let value : String?
        
        enum CodingKeys: String, CodingKey {
            case source = "Source"
            case value = "Value"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            source = try values.decodeIfPresent(String.self, forKey: .source)
            value = try values.decodeIfPresent(String.self, forKey: .value)
        }
    }
}

