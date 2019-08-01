//
//  BOBaseResponse.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import CodableExtensions
import SwiftDate

extension BO {
    class BaseResponse : Codable {
        var errorCode:String? = nil
        var errorDescription:String? = nil
        var errorHeader:String? = nil
        var tokenExpiryDate : DateInRegion?

        fileprivate enum CodingKeys: String, CodingKey {
            case errorCode = "errorCode"
            case errorDescription = "errorDescription"
            case errorHeader = "errorHeader"
            case tokenExpiryDate = "tokenExpiryDate"
        }
        
        init() { }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            errorCode = try? values.decode(.errorCode)
            errorDescription = try? values.decode(.errorDescription)
            errorHeader = try? values.decode(.errorHeader)
            tokenExpiryDate = try? values.decode(.tokenExpiryDate, transformer: StringDateInRegionTransformer.iso8601s)
        }
    }
}
