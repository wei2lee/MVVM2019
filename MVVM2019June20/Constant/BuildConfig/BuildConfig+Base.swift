//
//  BaseBuildConfig.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

class BaseBuildConfig : BuildConfigType {
    //MARK: BO
    var boRequestSignaturePrivateKey: String { return "123" }
    //MARK: OMDb
    var OMDbBaseURL: URL { return URL(string: "http://www.omdbapi.com/?i=\(OMDbApiKeyI)&apikey=\(OMDbApiKey)")! }
    var OMDbApiKey: String { return "cfea5f08" }
    var OMDbApiKeyI: String { return "tt3896198"}
    //MARK: App
    var localRegion: EnumRegion { return .malaysia }
    //MARK: Realm
    var enableAutoRecoveryFromRealmMigrationFail:Bool { return false }
    //MARK: JailBreakDetection
    var enableDetectJailBreak:Bool { return false }
    //MARK: Network Request
    var networkRequestTimeoutInterval: TimeInterval { return 60 }
    //MARK: Force Update
    var enableForceUpdate:Bool { return true }
    var appStoreURL:URL { return URL(string: "")! }
    //MARK: NetworkLogging
    var enableNetworkLogging:Bool { return true }
    //MARK: NetworkStubbing
    var enableNetworkStubbing:Bool { return false }
    //MARK: BugFender
    var bugFenderKey:String { return "" }
}
