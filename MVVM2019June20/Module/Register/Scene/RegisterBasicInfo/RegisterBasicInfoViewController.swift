//
//  RegisterBasicInfoViewController.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 01/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxBiBinding
import IQKeyboardManagerSwift

class RegisterBasicInfoViewController: BaseViewController<RegisterBasicInfoViewModel>, RegisterBasicInfoViewType {
    //Dependency
    @Injected var validationService: RegisterBasicInfoValidationServiceType
    //Outlets
    @IBOutlet var formView: RegisterBasicInfoFormView!
    //State
    var intent: RegisterBasicInfoIntent!
    fileprivate lazy var returnKeyHandler: IQKeyboardReturnKeyHandler = {
        let ret = IQKeyboardReturnKeyHandler(controller: self)
        ret.lastTextFieldReturnKeyType = .done
        return ret
    }()
    //View Cycle
    override func loadView() {
        super.loadView()
        intent = RegisterBasicInfoIntent()
        viewModel = DI.resolver.resolve(RegisterBasicInfoViewModel.self, argument: intent!)!
    }
    override func setupView() {
        super.setupView()
        //NavigationBar
        navigationItem.title = "REGISTER"
        //Form
        formView.firstNameRow.titleText = "First Name"
        formView.firstNameRow.textField.keyboardType = .namePhonePad
        formView.firstNameRow.validateClosure = { [unowned self] in
            self.validationService.validateFirstname($0)?.error
        }
        formView.lastNameRow.titleText = "Last Name"
        formView.lastNameRow.textField.keyboardType = .namePhonePad
        formView.lastNameRow.validateClosure = { [unowned self] in
            self.validationService.validateLastname($0)?.error
        }
        formView.emailRow.titleText = "Email Address"
        formView.emailRow.textField.keyboardType = .emailAddress
        formView.emailRow.validateClosure = { [unowned self] in
            self.validationService.validateEmail($0)?.error
        }
        formView.passwordRow.titleText = "Password"
        formView.passwordRow.textField.isSecureTextEntry = true
        formView.passwordRow.validateClosure = { [unowned self] in
            self.validationService.validatePassword($0)?.error
        }
        formView.confirmPasswordRow.titleText = "Confirm Password"
        formView.confirmPasswordRow.textField.isSecureTextEntry = true
        formView.confirmPasswordRow.validateClosure = { [unowned self] _ in
            let password = self.formView.passwordRow.value
            let confirmPassword = self.formView.confirmPasswordRow.value
            return self.validationService.validatePasswordAndConfirmPassword(password,  confirmPassword)?.error
        }
        _ = returnKeyHandler
    }
    override func setupTransformInput() {
        super.setupTransformInput()
        viewModel.view = self
        viewModel.startLoad = rx.viewWillAppearForFirstTime
        disposeBag.insert(
            formView.firstNameRow.rx.value <-> viewModel.firstName,
            formView.lastNameRow.rx.value <-> viewModel.lastName,
            formView.emailRow.rx.value <-> viewModel.email,
            formView.passwordRow.rx.value <-> viewModel.password,
            formView.confirmPasswordRow.rx.value <-> viewModel.confirmPassword,
            formView.firstNameRow.rx.validationState <-> viewModel.firstNameState,
            formView.lastNameRow.rx.validationState <-> viewModel.lastNameState
        )
        viewModel.startNext = rx.validateFormOnNext
    }
    //MARK: <RegisterBasicInfoViewType>
    func routeToNext() {
        let screen = DI.resolver.resolve(RegisterMigrationViewControllerType.self)!
        navigationController?.pushViewController(screen)
    }
    
    func dismissView() {
        self.exitWithResult()
    }
}

extension Reactive where Base : RegisterBasicInfoViewController {
    var validateFormOnNext: Driver<Void> {
        return base.formView.nextButton.rx.tap.asDriver().flatMap {
            self.base.formView.validate()
            if self.base.formView.isAllRowsValidateSuccess {
                return .just(())
            } else {
                return .empty()
            }
        }
    }
}
