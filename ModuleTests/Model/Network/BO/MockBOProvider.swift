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
    
    static let Mock = BO.MockProvider(stubClosure: { o in BO.MockProvider.stubBehavior(o, stubMinDelayed: 0.1, stubMaxDelayed: 0.1)})
    
    static let MockNoInternet = BO.MockProvider(endpointClosure: { o in BO.MockProvider.createErrorEndPoint(target: o, dataPath: "", error: NetworkError.noInternetConnection.error)},
                                stubClosure: { o in BO.MockProvider.stubBehavior(o, stubMinDelayed: 0.1, stubMaxDelayed: 0.1)})
    
    static let MockAppInfoForceUpdate = BO.MockProvider(
        endpointClosure: { o in
            if let _ = o as? BO.EndPoint.AppInfo {
                BO.MockProvider.createEndPoint(target: o, dataPath: "appinfoforceupdate_response")
            }
            return BO.MockProvider.defaultEndpointMapping(for: o)
        },
        stubClosure: { o in BO.MockProvider.stubBehavior(o, stubMinDelayed: 0.1, stubMaxDelayed: 0.1)})
}
