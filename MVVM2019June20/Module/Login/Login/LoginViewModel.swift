//
//  LoginViewModel.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 20/06/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class LoginViewModel: BaseViewModel, LoginViewModelType {
    var a = 1
    fileprivate typealias Form = (username: String, password: String)
    //MARK: Input
    public let username = BehaviorRelay<String?>(value: nil)
    public let password = BehaviorRelay<String?>(value: nil)
    public var startSubmit: Driver<Void> = .never()
    //MARK: Output
    public weak var view: LoginViewType? = nil
    public let footerText = BehaviorRelay<String?>(value: nil)
    public let showNavigationBar: Bool
    public let isModalInPresentation: Bool
    public let showClose: Bool
    //MARK: Dependency
    @Injected fileprivate var authService: AuthServiceType
    @Injected fileprivate var validationService: LoginFormValidationServiceType
    //MARK: State
    let intent: LoginIntent
    fileprivate var formValue: Form {
        return (username: username.value.orEmpty,
                password: password.value.orEmpty)
    }
    fileprivate var form: Driver<Form> {
        return Driver.combineLatest([username.asDriver().distinctUntilChanged().asVoid(),
                                     password.asDriver().distinctUntilChanged().asVoid()])
            .debounce(.milliseconds(10))
            .map { _ in self.formValue }
    }
    //MARK: initializer
    init(intent: LoginIntent) {
        self.intent = intent
        showNavigationBar = intent.isModal
        isModalInPresentation = !intent.enableDismiss
        showClose = intent.enableDismiss
        super.init()
    }
    //MARK: transform
    override func transform() {
        super.transform()
        let footerText = startLoad.map{ SwifterSwift.appVersion.orEmptyReplacement }
        let convertForm = startLoad.flatMapLatest(self.convertForm)
        let form = self.form
        let doSubmit = startSubmit
            .withLatestFrom(form)
            .flatMapLatest(self.validate)
            .withLatestFrom(form)
            .flatMapLatest(self.login)
            .do(onNext: self.loginRoute)
        let doDismissView = startExit.do(onNext: { self.view?.dismissView() })
        _ = self.transformErrorHandling(input: ErrorHandlingInput(view: view, errorTracker: errorTracker))
        //subscribe
        disposeBag.insert(
            footerText.drive(self.footerText),
            convertForm.drive(),
            doSubmit.drive(),
            doDismissView.drive()
        )
    }
    override func dispose() {
        super.dispose()
    }
    //MARK: Helper
    fileprivate func convertForm() -> Driver<Void> {
        return username.asDriver().distinctUntilChanged().do(onNext: { string in
            let oldString: String = string.orEmpty
            let newString: String = string.orEmpty.uppercased()
            if newString != oldString {
                DispatchQueue.main.async {
                    self.username.accept(newString)
                }
            }
        }).asVoid()
    }
    fileprivate func validate(username: String, password: String) -> Driver<Void> {
        if let error = self.validationService.validate(username: username,
                                                       password: password) {
            return Observable.error(error)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        } else {
            return .just(())
        }
    }
    
    fileprivate func login(username: String, password: String) -> Driver<Void> {
        return self.authService.login(username: username,
                                      password: password).asVoid()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .trackActivity(self.activityIndicator)
            .trackError(self.errorTracker)
            .asDriverOnErrorJustComplete()
    }
    
    fileprivate func loginRoute() {
        if self.Defaults[.isActivated] == false {
            view?.routeToActivation()
        } else {
            view?.routeToDashboard()
        }
    }
}
