//
//  UIViewController+PresentDialogProtocol.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 27/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift

extension UIViewController: PresentDialogProtocol {
    func presentDialog(title: String?, message: String?, actions: [String]) -> Driver<Int> {
        let impl = PresentDialogProtocolImpl(base: self)
        return impl.presentDialog(title: title, message: message, actions: actions)
    }
    
    func presentDialog(title: String?, message: String?, actions: [DialogAction]) -> Driver<DialogAction> {
        let impl = PresentDialogProtocolImpl(base: self)
        return impl.presentDialog(title: title, message: message, actions: actions)
    }
    
    func presentDialog(title: String?, message: String?, action: DialogAction) -> Driver<DialogAction> {
        let impl = PresentDialogProtocolImpl(base: self)
        return impl.presentDialog(title: title, message: message, action: action)
    }
}
