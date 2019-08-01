//
//  PresentDialogProtocol.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 22/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PresentDialogProtocol {
    func presentDialog(title: String?, message: String?, actions: [String]) -> Driver<Int>
    func presentDialog(title: String?, message: String?, actions: [DialogAction]) -> Driver<DialogAction>
    func presentDialog(title: String?, message: String?, action: DialogAction) -> Driver<DialogAction>
}
