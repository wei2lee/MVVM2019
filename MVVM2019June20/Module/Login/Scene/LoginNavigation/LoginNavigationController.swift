//
//  LoginNavigationController.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 31/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

class LoginNavigationController: UINavigationController, LoginNavigationViewType {
    var intent: LoginNavigationIntent! = LoginNavigationIntent(isModal: false,
                                                               initialView: .login,
                                                               enableDismiss: true)
    override func viewDidLoad() {
        super.viewDidLoad()
        switch intent.initialView {
        case .login:
            self.setViewControllers([createLogin()], animated: false)
        case .activation:
            self.setViewControllers([createLogin(), createActivation()], animated: false)
        }
    }
    fileprivate func createLogin() -> UIViewController {
        let screen = DI.resolver.resolve(LoginViewControllerType.self)!
        screen.intent = intent
        return screen
    }
    fileprivate func createActivation() -> UIViewController {
        let screen = DI.resolver.resolve(ActivationViewControllerType.self)!
        return screen
    }
}
