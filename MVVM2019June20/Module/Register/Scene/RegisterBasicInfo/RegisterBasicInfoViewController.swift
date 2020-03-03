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

class RegisterBasicInfoViewController: BaseViewController<RegisterBasicInfoViewModel>, RegisterBasicInfoViewType {
    //Dependency
    @Injected var validationService: RegisterBasicInfoValidationServiceType
    //Outlets
    @IBOutlet var formView: RegisterBasicInfoFormView!
    //State
    var intent: RegisterBasicInfoIntent!
    //View Cycle
    override func loadView() {
        super.loadView()
        viewModel = DI.container.resolve(RegisterBasicInfoViewModel.self, argument: intent)!
    }
    override func setupView() {
        super.setupView()
        //Form
        formView.firstNameRow.textField.keyboardType = .namePhonePad
        formView.firstNameRow.validateClosure = { [unowned self] in
            ValidationState(error: self.validationService.validateFirstname($0)?.error)
        }
        formView.lastNameRow.textField.keyboardType = .namePhonePad
        formView.lastNameRow.validateClosure = { [unowned self] in
            ValidationState(error: self.validationService.validateLastname($0)?.error)
        }
        formView.emailRow.textField.keyboardType = .emailAddress
        formView.emailRow.validateClosure = { [unowned self] in
            ValidationState(error: self.validationService.validateEmail($0)?.error)
        }
        formView.passwordRow.textField.isSecureTextEntry = true
        formView.passwordRow.validateClosure = { [unowned self] in
            ValidationState(error: self.validationService.validatePassword($0)?.error)
        }
        formView.confirmPasswordRow.textField.isSecureTextEntry = true
        formView.confirmPasswordRow.validateClosure = { [unowned self] _ in
            let password = self.formView.passwordRow.value
            let confirmPassword = self.formView.confirmPasswordRow.value
            return ValidationState(error: self.validationService.validatePasswordAndConfirmPassword(password,  confirmPassword)?.error)
        }
    }
    override func setupTransformInput() {
        super.setupTransformInput()
        viewModel.view = self
        disposeBag.insert(
            formView.firstNameRow.rx.value <-> viewModel.firstName,
            formView.lastNameRow.rx.value <-> viewModel.lastName,
            formView.emailRow.rx.value <-> viewModel.email,
            formView.passwordRow.rx.value <-> viewModel.password,
            formView.confirmPasswordRow.rx.value <-> viewModel.confirmPassword
        )
        viewModel.startNext = rx.validateFormOnNext
    }
    //MARK: <RegisterBasicInfoViewType>
    func routeToNext() {
        let screen = DI.container.resolve(RegisterMigrationViewControllerType.self)!
        navigationController?.pushViewController(screen)
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
