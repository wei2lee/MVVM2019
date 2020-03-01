//
//  SplashTypes.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 02/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SplashViewType: BaseViewType {
    func routeToLogin()
    func routeToActivation()
    func routeToDashboard()
    func promptNoInternetConnectionRetryDialog() -> Driver<Void>
    func promptRetryDialog() -> Driver<Void>
    func promptForceUpdateDialog() -> Driver<Void>
    func promptJailBrokenDetectedDialog() -> Driver<Void>
}

typealias SplashViewControllerType = UIViewController & SplashViewType

protocol SplashDataUseCaseType {
    func appInfo() -> Observable<BO.ResponseAppInfo>
    var isActivated: Bool { set get }
}
