//
//  SplashViewController.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 02/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift

class SplashViewController: BaseViewController<SplashViewModel>
{
    //MARK: outlets
    //MARK: state
    //MARK: viewCycle
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(SplashViewModel.self)!
    }
    override func setupView() {
        super.setupView()
    }
    override func setupTransformInput() {
        super.setupTransformInput()
        viewModel.view = self
        viewModel.startLoad = rx.viewWillAppearForFirstTime
    }
    override func subscribe() {
        super.subscribe()
    }
}
//MARK: <SplashViewType>
extension SplashViewController: SplashViewType {
    func routeToLogin() {
        var screen = DI.resolver.resolve(LoginNavigationControllerType.self)!
        screen.intent = LoginNavigationIntent(isModal: false,
                                              initialView: .login,
                                              enableDismiss: true)
        SwifterSwift.sharedApplication.keyWindow?.rootViewController = screen
    }
    
    func routeToActivation() {
        var screen = DI.resolver.resolve(LoginNavigationControllerType.self)!
        screen.intent = LoginNavigationIntent(isModal: false,
                                              initialView: .activation,
                                              enableDismiss: true)
        SwifterSwift.sharedApplication.keyWindow?.rootViewController = screen
    }
    
    func routeToDashboard() {
        let screen = DI.resolver.resolve(DashboardNavigationControllerType.self)!
        SwifterSwift.sharedApplication.keyWindow?.rootViewController = screen
    }
    
    func promptNoInternetConnectionRetryDialog() -> Driver<Void> {
        return self.presentDialog(title: "No internet connection",
                           message: "You doesn't seem connected to the internet. Please check your connection and try again.",
                           action: .retry()).asVoid()
    }
    
    func promptRetryDialog() -> Driver<Void> {
        return self.presentDialog(title: "Oh!",
                           message: "Something went wrong. Please check your connection and try again.",
                           action: .retry()).asVoid()
    }
    
    func promptForceUpdateDialog() -> Driver<Void> {
        return self.presentDialog(title: "Force update",
                           message: "New version is available.",
                           action: .download()).asVoid()
    }
    
    func promptJailBrokenDetectedDialog() -> Driver<Void> {
        return self.presentDialog(title: "Device is jailbroken",
                           message: "Application will terminated.",
                           action: .ok()).asVoid().do(onNext: { _ in
                                exit(0)
                           })
    }
    
}




