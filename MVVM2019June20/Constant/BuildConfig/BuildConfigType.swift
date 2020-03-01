//
//  BuildConfig.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

protocol BuildConfigType {
    //MARK: BO
    var boRequestSignaturePrivateKey: String { get }
    //MARK: OMDB
    var OMDbBaseURL: URL { get }
    var OMDbApiKey: String { get }
    var OMDbApiKeyI: String { get }
    //MARK: App
    var localRegion: EnumRegion { get }
    //MARK: Realm
    var enableAutoRecoveryFromRealmMigrationFail:Bool { get }
    //MARK: JailBreakDetection
    var enableDetectJailBreak:Bool { get }
    //MARK: Network Request
    var networkRequestTimeoutInterval: TimeInterval { get }
    //MARK: Force Update
    var enableForceUpdate:Bool { get }
    var appStoreURL:URL { get }
    //MARK: NetworkLogging
    var enableNetworkLogging:Bool { get }
    //MARK: NetworkStubbing
    var enableNetworkStubbing:Bool { get }
    //MARK: BugFender
    var bugFenderKey:String { get }
}
