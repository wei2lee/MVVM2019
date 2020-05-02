//
//  LoginViewModelSpec.swift
//  ModuleTests
//
//  Created by Yee Chuan Lee on 01/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import Nimble
import Quick
import RxBlocking
import RxSwift
import RxCocoa
@testable import MVVM2019June20

fileprivate class MockLoginView: MockBaseView, LoginViewType {
    func routeToRegister() {
        
    }
    
    var intent: LoginIntent!
    
    override init() {
        
    }
    
    var isRouteToActivation = false
    func routeToActivation() {
        isRouteToActivation = true
    }
    
    var isRouteToDashboard = false
    @objc func routeToDashboard() {
        isRouteToDashboard = true
    }
    
    func dismissView() {
        
    }
    
}

extension LoginViewModel {
    fileprivate static func setupLoginViewModelDI() {
        BaseViewModel.setupBaseViewModelDI()
        DI.container.register(LoginFormValidationServiceType.self, factory: { r -> LoginFormValidationServiceType in
            return LoginFormValidationService()
        }).inObjectScope(.container)
        
        DI.container.register(AuthServiceType.self, factory: { r -> AuthServiceType in
            return MockAuthService()
        }).inObjectScope(.container)
    }
}


class LoginViewModelSpec: QuickSpec {
    var retains: [Any] = []
    override func spec() {
        let intent = LoginIntent(isModal: false,
                                 initialView: .login,
                                 enableDismiss: false)
        var object: LoginViewModel!
        var view: MockLoginView!
        describe("LoginViewModel") {
            beforeEach {
                DI.container.removeAll()
                LoginViewModel.setupLoginViewModelDI()
                object = LoginViewModel(intent: intent)
                view = MockLoginView()
                self.retains.append(view!)
                object.view = view
                object.startLoad = .just(())
            }
            context("inputting form") {
                it("username entered will converted to uppercase") {
                    object.transform()
                    object.username.accept("abc")
                    expect( object.username.value ).toEventually(equal( "ABC" ))
                }
            }
            context("submitting form") {
                it("prompt error dialog for empty username") {
                    let startSubmit = PublishRelay<Void>()
                    object.startSubmit = startSubmit.asDriverOnErrorJustComplete()
                    object.transform()
                    object.username.accept("")
                    object.password.accept("password")
                    startSubmit.accept(())
                    expect( view.isPresentedError ).toEventually(equal( true ))
                }
                it("prompt error dialog for empty password") {
                    let startSubmit = PublishRelay<Void>()
                    object.startSubmit = startSubmit.asDriverOnErrorJustComplete()
                    object.transform()
                    object.username.accept("username")
                    object.password.accept("")
                    startSubmit.accept(())
                    expect( view.isPresentedError ).toEventually(equal( true ))
                }
                it("prompt error dialog for no internet connection") {
                    DI.container.register(AuthServiceType.self, factory: { r -> AuthServiceType in
                        return MockNoInternetAuthService()
                    }).inObjectScope(.container)
                    
                     let startSubmit = PublishRelay<Void>()
                     object.startSubmit = startSubmit.asDriverOnErrorJustComplete()
                     object.transform()
                     object.username.accept("A")
                     object.password.accept("a")
                     startSubmit.accept(())
                     expect( view.isPresentedError ).toEventually(equal( true ))
                 }
                it("route to activation if not activated") {
                    DI.container.register(UserDefaults.self, factory: { r -> UserDefaults in
                        return UserDefaults.NotActivated
                    }).inObjectScope(.container)
                    
                    let startSubmit = PublishRelay<Void>()
                    object.startSubmit = startSubmit.asDriverOnErrorJustComplete()
                    object.transform()
                    object.username.accept("A")
                    object.password.accept("a")
                    startSubmit.accept(())
                    expect( view.isRouteToActivation ).toEventually(equal( true ))
                }
                it("route to dashboard if activated") {
                    DI.container.register(UserDefaults.self, factory: { r -> UserDefaults in
                        return UserDefaults.Activated
                    }).inObjectScope(.container)
                    
                    let startSubmit = PublishRelay<Void>()
                    object.startSubmit = startSubmit.asDriverOnErrorJustComplete()
                    object.transform()
                    object.username.accept("A")
                    object.password.accept("a")
                    startSubmit.accept(())
                    expect( view.isRouteToDashboard ).toEventually(equal( true ))
                }
            }
        }
    }
}

