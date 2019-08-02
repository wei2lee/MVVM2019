//
//  StringDateInRegionTransformer.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import CodableExtensions
import Moya
import SwiftDate

class StringDateInRegionTransformer: CodingContainerTransformer {
    typealias Input = String
    typealias Output = DateInRegion
    
    let inputRegion: Region
    let outputRegion: Region
    let formats: [String]
    
    init(inputRegion: Region, outputRegion: Region, formats: [String]) {
        self.inputRegion = inputRegion
        self.outputRegion = outputRegion
        self.formats = formats
    }
    func transform(_ decoded: Input) throws -> Output {
        if let ret = decoded.toDate(self.formats, region: inputRegion)?.convertTo(region: outputRegion) {
            return ret
        } else {
            let e = NSError(domain: "app.decoding",
                            code: 0, localizedTitle: "",
                            localizedDescription: "StringDateInRegionTransformer")
            throw MoyaError.encodableMapping(e)
        }
    }
    func transform(_ encoded: Output) throws -> Input {
        return encoded.convertTo(region: inputRegion).toString(.custom(formats.first!))
    }
}
