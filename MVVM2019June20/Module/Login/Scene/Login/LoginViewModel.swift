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
    fileprivate typealias Form = (username: String, password: String)
    //MARK: Input
    public let username = BehaviorRelay<String?>(value: nil)
    public let password = BehaviorRelay<String?>(value: nil)
    @ViewEvent var startSubmit: Driver<Void> = .never()
    @ViewEvent var startRegister: Driver<Void> = .never()
    //MARK: Output, ViewMapping
    public weak var view: LoginViewType? = nil
    public let footerText = BehaviorRelay<String?>(value: nil)
    public let showNavigationBar: Bool
    public let isModalInPresentation: Bool
    public let showClose: Bool
    //MARK: Dependency //Property Wrapper, write a future unit testable code
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
        let routeToRegister = startRegister.do(onNext: { self.view?.routeToRegister() })
        _ = self.transformErrorHandling(input: ErrorHandlingInput(view: view, errorTracker: errorTracker))
        //subscribe
        disposeBag.insert(
            footerText.drive(self.footerText),
            convertForm.drive(),
            doSubmit.drive(),
            doDismissView.drive(),
            routeToRegister.drive()
        )
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
            
            //example code for checking error, with switch and enumeraiton (while the typing is still available)
            switch error {
                case .usernameIsEmpty:
                    break
                case .passwordIsEmpty:
                    break
                case .usernameAndPasswordIsEmpty:
                    break
                case .generic:
                    break
            }
            //example code for checking error, with switch and enumeraiton (while the typing is still available)
            
            return Observable.error(error)
                //example code for checking error, with switch and enumeraiton (after converting into Error)
                .do(onError: { (error: Error) in
                    switch LoginFormValidationError(error: error.error) {
                    case .usernameIsEmpty?:
                        break
                    case .passwordIsEmpty?:
                        break
                    case .usernameAndPasswordIsEmpty?:
                        break
                    case .generic?:
                        break
                    default:
                        break
                    }
                })
                //example code for checking error, with switch and enumeraiton (after converting into Error) end
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
            
            //example code for accessing Error object, as Error Enumeration, switch statement
            .do(onError: { (error: Error) in
                if let error = NetworkError(error: error.error) {
                    switch error {
                    case .generic:
                        break
                    case .noInternetConnection:
                        break
                    case .connectionTimeout:
                        break
                    }
                } else if let error = BO.Error(error: error.error) {
                    switch error {
                    case .response(let response):
                        break
                    case .invalidSignature:
                        break
                    case .generic:
                        break
                    default:
                        break
                    }
                } else {
                    
                }
                
                //example code for accessing BO response in Error object:
                //let response: BO.BaseResponse? = error.error.boResponse
            })
            //example code for accessing Error object
            
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
