//
//  DialogAction+Extension.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 09/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension DialogAction {
    static func OK() -> DialogAction {
        let title = "OK"
        return DialogAction(title: title, style: .default, kind: .positive)
    }
}
