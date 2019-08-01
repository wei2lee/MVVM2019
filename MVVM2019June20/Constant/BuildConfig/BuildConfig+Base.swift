//
//  BaseBuildConfig.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

class BaseBuildConfig : BuildConfigType {
    var OMDbBaseURL: URL { return URL(string: "http://www.omdbapi.com/?i=\(OMDbApiKeyI)&apikey=\(OMDbApiKey)")! }
    var OMDbApiKey: String { return "cfea5f08" }
    var OMDbApiKeyI: String { return "tt3896198"}
    var localRegion: EnumRegion { return .malaysia }
}
