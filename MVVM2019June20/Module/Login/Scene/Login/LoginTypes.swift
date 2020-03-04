//
//  LoginViewType.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewType: BaseViewType {
    var intent: LoginIntent! { set get }
    func routeToActivation()
    func routeToDashboard()
    func routeToRegister()
    func dismissView()
}

typealias LoginViewControllerType = UIViewController & LoginViewType

protocol LoginViewModelType: BaseViewModelType {
    //MARK: Input
    var username : BehaviorRelay<String?> { get }
    var password : BehaviorRelay<String?> { get }
    var startSubmit: Driver<Void> { set get }
    //MARK: Output
    var view: LoginViewType? { set get }
    var footerText: BehaviorRelay<String?> { get }
}

