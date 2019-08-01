//
//  OMDbBaseResponse.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import CodableExtensions

extension OMDb {
    class BaseResponse : Codable {
        var error : String?
        var response : Bool?

        fileprivate enum CodingKeys: String, CodingKey {
            case error = "Error"
            case response = "Response"
        }
        
        init() { }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            error = try values.decodeIfPresent(String.self, forKey: .error)
            response = try values.decode(.response, transformer: StringBoolTransformer.shared)
        }
    }
}

