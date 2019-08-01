//
//  UniversalPresentDialogProtocolImpl.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 11/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DeviceKit

class PresentDialogProtocolIPadImpl: PresentDialogProtocolImpl {
    override func presentDialog(title: String?, message: String?, actions: [String]) -> Driver<Int> {
        guard base != nil else { return .empty() }
        return super.presentDialog(title: title, message: message, actions: actions)
    }
    
    override func presentDialog(title: String?, message: String?, actions: [DialogAction]) -> Driver<DialogAction> {
        guard base != nil else { return .empty() }
        return super.presentDialog(title: title, message: message, actions: actions)
    }
}
