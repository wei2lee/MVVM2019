//
//  BOMockPlugin.swift
//  ModuleTests
//
//  Created by Yee Chuan Lee on 05/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import Moya
@testable import MVVM2019June20

extension BO.MockProvider {
    
    static let UnitTest = BO.MockProvider(stubClosure: { o in BO.MockProvider.stubBehavior(o, stubMinDelayed: 0.1, stubMaxDelayed: 0.1)})
    
    static let UnitTestWithNoInternet = BO.MockProvider(endpointClosure: { o in BO.MockProvider.createErrorEndPoint(target: o, dataPath: "", error: NetworkError.noInternetConnection.error)},
                                stubClosure: { o in BO.MockProvider.stubBehavior(o, stubMinDelayed: 0.1, stubMaxDelayed: 0.1)})
}
