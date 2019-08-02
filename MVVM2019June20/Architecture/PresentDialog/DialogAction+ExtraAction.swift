//
//  DialogAction+Extension.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 09/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension DialogAction {
    static func download() -> DialogAction {
        let title = "DOWNLOAD"
        return DialogAction(title: title, style: .default, kind: .positive)
    }
    static func refresh() -> DialogAction {
        let title = "REFRESH"
        return DialogAction(title: title, style: .default, kind: .positive)
    }
    static func retry() -> DialogAction {
        let title = "RETRY"
        return DialogAction(title: title, style: .default, kind: .positive)
    }
}
