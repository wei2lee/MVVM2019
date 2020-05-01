//
//  LoginViewController.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 20/06/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift
import RxBiBinding
import SwifterSwift

class LoginViewController: BaseViewController<LoginViewModel>
{
    //MARK: outlets
    @IBOutlet var formView: LoginFormView!
    @IBOutlet var footerView: LoginFooterView!
    //MARK: state
    var intent: LoginIntent!
    fileprivate lazy var returnKeyHandler: IQKeyboardReturnKeyHandler = {
        let ret = IQKeyboardReturnKeyHandler(controller: self)
        ret.lastTextFieldReturnKeyType = .done
        return ret
    }()
    //MARK: viewCycle
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(LoginViewModel.self, argument: intent!)!
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = !viewModel.showNavigationBar
    }
    override func setupView() {
        super.setupView()
        if #available(iOS 13.0, *) {
            isModalInPresentation = viewModel.isModalInPresentation
        } else {
        }
        //NavigationBar
        navigationItem.title = "Login"
        if viewModel.showClose {
            leftBarItem = .close(closure: nil)
        }
        //Form
        formView.usernameTextField.keyboardType = .default
        formView.usernameTextField.spellCheckingType = .no
        formView.passwordTextField.isSecureTextEntry = true
        _ = returnKeyHandler
    }
    override func setupTransformInput() {
//iOS vanilla SDK, they providing callback, event like delegate, closure, NotificationCenter, addTarget(self. event)
        //has convert into Driver(event), ControlProperty,
        //most of UIComponent library, RxCocoa provide UIComponent binding event
        
        super.setupTransformInput()
        viewModel.view = self
        viewModel.startExit = rx.leftBarButtonItem(.close())
        viewModel.startLoad = rx.viewWillAppearForFirstTime
        viewModel.startSubmit = rx.startSubmit
        viewModel.startRegister = formView.registerButton.rx.tap.asDriver()
    }
    override func subscribe() {
        super.subscribe()
        disposeBag.insert(
            //Form
            formView.passwordTextField.rx.text <-> viewModel.password,
            //Footer
            viewModel.footerText.bind(to: footerView.label.rx.text)
        )
    }
}
//MARK: <LoginViewType>
extension LoginViewController: LoginViewType {
    func routeToActivation() {
        if intent.isModal {
            var screen = DI.resolver.resolve(LoginNavigationControllerType.self)!
            screen.intent = LoginNavigationIntent(isModal: false,
                                                  initialView: .activation,
                                                  enableDismiss: true)
            SwifterSwift.sharedApplication.keyWindow?.rootViewController = screen
        } else {
            let screen = DI.resolver.resolve(ActivationViewControllerType.self)!
            navigationController?.pushViewController(screen)
        }
    }
    
    func routeToDashboard() {
        let screen = DI.resolver.resolve(DashboardNavigationControllerType.self)!
        SwifterSwift.sharedApplication.keyWindow?.rootViewController = screen
    }
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    func routeToRegister() {
        let screen = DI.resolver.resolve(RegisterNavigationControllerType.self)!
        self.present(screen, animated: true, completion: nil)
    }
}
//MARK: rx
extension Reactive where Base : LoginViewController {
    var startSubmit: Driver<Void> {
        var triggers: [Driver<Void>] = []
        triggers += [base.formView.submitButton.rx.tap.asDriver().asVoid()]
        triggers += [base.formView.passwordTextField.rx.shouldReturn.asDriver()]
        return Driver.merge(triggers)
    }
}
//MARK: View
class LoginFormView: UIView {
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var registerButton: UIButton!
}
class LoginFooterView: UIView {
    @IBOutlet var label: UILabel!
}


