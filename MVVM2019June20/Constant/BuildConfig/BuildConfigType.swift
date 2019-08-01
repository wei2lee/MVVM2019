//
//  BuildConfig.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

protocol BuildConfigType {
    var OMDbBaseURL: URL { get }
    var OMDbApiKey: String { get }
    var OMDbApiKeyI: String { get }
    var localRegion: EnumRegion { get }
}
