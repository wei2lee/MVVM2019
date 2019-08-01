//
//  DismissWithResultProtocol.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 29/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa

protocol DismissWithResultProtocol: class, DismissWithResultProtocolHelper {
    var dismissIdentifier: Any? { set get }
    var onDismissResult: PublishRelay<DismissResult> { get }
}

@objc protocol DismissWithResultProtocolHelper {
    func exitWithResult(animated: Bool, result: DismissResult, completion: (()->())?)
    func closeWithResult(animated: Bool, result: DismissResult, completion: (()->())?)
    func popWithResult(animated: Bool, result: DismissResult, completion: (()->())?)
}
