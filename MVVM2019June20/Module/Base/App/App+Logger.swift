//
//  App+Logger.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 03/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import XCGLogger

typealias LogTag = Tag
extension LogTag {
    static let form = Tag("Form")
    static let objectMapper = Tag("objectMapper")
    static let loginLoginService = Tag("UserLoginService")
    static let realmMigration = Tag("realmMigration")
    static let deeplinking = Tag("deeplinking")
    static let clearup = Tag("clearup")
    static let ui = Tag("ui")
    static let dropDown = Tag("dropDown")
    static let segue = Tag("segue")
    static let network = Tag("network")
    static let presentError = Tag("presentError")
    static let rxSwift = Tag("RxSwift")
    static let notification = Tag("notification")
    static let filter = Tag("filter")
    static let calendarRepository = Tag("calendarRepository")
    static let destruction = Tag("destruction")
    static let cache = Tag("cache")
}

let Log = XCGLogger.default

extension AppDelegate {
    func setupLogger() {
        Log.setup(level: .debug,
                  showThreadName: true,
                  showLevel: true,
                  showFileNames: true,
                  showLineNumbers: true,
                  writeToFile: nil,
                  fileLevel: .debug)
        Log.filters = [TagFilter(excludeFrom: [LogTag.clearup])]
    }
}
