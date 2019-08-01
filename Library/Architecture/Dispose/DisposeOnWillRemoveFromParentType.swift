//
//  DisposeOnWillRemoveFromParentType.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 28/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa

protocol DisposeOnWillRemoveFromParentType: class {
    var disposeOnWillRemoveFromParent:Bool { set get }
}
