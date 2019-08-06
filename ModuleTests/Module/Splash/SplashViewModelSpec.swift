//
//  SplashViewModelSpec.swift
//  ModuleTests
//
//  Created by Yee Chuan Lee on 05/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import Nimble
import Quick
import RxBlocking
import RxSwift
import RxCocoa
@testable import MVVM2019June20

fileprivate class MockSplashView: NSObject, SplashViewType {
    
    
    override init() {
        
    }
    var isRouteToLogin = false
    func routeToLogin() {
        isRouteToLogin = true
    }
    var isRouteToActivation = false
    func routeToActivation() {
        isRouteToActivation = true
    }
    var isRouteToDashboard = false
    func routeToDashboard() {
        isRouteToDashboard = true
    }
    var isPromptNoInternetConnectionRetryDialog = false
    func promptNoInternetConnectionRetryDialog() -> Driver<Void> {
        return Driver.just(()).do(onSubscribed: {
            self.isPromptNoInternetConnectionRetryDialog = true
        })
    }
    var isPromptRetryDialog = false
    func promptRetryDialog() -> Driver<Void> {
        return Driver.just(()).do(onSubscribed: {
                    self.isPromptForceUpdateDialog = true
                })
    }
    var isPromptForceUpdateDialog = false
    func promptForceUpdateDialog() -> Driver<Void> {
        return Driver.just(()).do(onSubscribed: {
                    self.isPromptForceUpdateDialog = true
                })
    }
    var isPromptJailBrokenDetectedDialog = false
    func promptJailBrokenDetectedDialog() -> Driver<Void> {
        return Driver.just(()).do(onSubscribed: {
                    self.isPromptJailBrokenDetectedDialog = true
                })
    }
    
    func dismissView() {
        
    }
    
    func showProgressHUD() {
        
    }
    
    func showProgressHUD(label: String) {
        
    }
    
    func hideProgressHUD() {
        
    }
    
    func exitToLogin() {
        
    }
    
    func presentDialog(title: String?, message: String?, actions: [String]) -> Driver<Int> {
        return .just(0)
    }
    
    func presentDialog(title: String?, message: String?, actions: [DialogAction]) -> Driver<DialogAction> {
        return .just(actions.first!)
    }
    
    func presentDialog(title: String?, message: String?, action: DialogAction) -> Driver<DialogAction> {
        return .just(action)
    }
    
    var disposeOnWillRemoveFromParent: Bool = false
    
    func showLoginSessionExpire(error: NSError) -> Driver<Void> {
        return .just(())
    }
    
    var isPresentedError: Bool = false
    func present(error: Error, completion: @escaping () -> ()) {
        isPresentedError = true
    }
    
    func exitWithResult(animated: Bool, result: DismissResult, completion: (() -> ())?) {
        
    }
    
    func closeWithResult(animated: Bool, result: DismissResult, completion: (() -> ())?) {
        
    }
    
    func popWithResult(animated: Bool, result: DismissResult, completion: (() -> ())?) {
        
    }
    
    
}

extension SplashViewModel {
    static func setupSplashViewModelDI() {
        BaseViewModel.setupBaseViewModelDI()
        DI.container.register(AuthServiceType.self, factory: { r -> AuthServiceType in
            return MockAuthService()
        }).inObjectScope(.container)
        
        DI.container.register(BO.Provider.self, factory: { r -> BO.Provider in
            let ret = BO.MockProvider.Mock
            return ret
        }).inObjectScope(.container)
        
        DI.container.register(LoginSessionRepositoryType.self, factory: { r -> LoginSessionRepositoryType in
            let ret = MockNewUserSessionLoginSessionRepository()
            return ret
        }).inObjectScope(.container)
    }
}

class SplashViewModelSpec: QuickSpec {
    var retains: [Any] = []
    override func spec() {
        var object: SplashViewModel!
        var view: MockSplashView!
        describe("after screen is shown") {
            beforeEach {
                DI.container.removeAll()
                SplashViewModel.setupSplashViewModelDI()
                object = SplashViewModel()
                view = MockSplashView()
                self.retains.append(view!)
                object.view = view
                object.startLoad = .just(())
            }
            context("force updpate") {
                it("prompt retry dialog if no internet connection") {
                    DI.container.register(AuthServiceType.self, factory: { r -> AuthServiceType in
                        return MockNoInternetAuthService()
                    }).inObjectScope(.container)
                    
                    object.transform()
                    
                    expect( view.isPromptNoInternetConnectionRetryDialog ).toEventually(equal( false ))
                }
                it("prompt force update dialog if require force update") {
                    DI.container.register(BO.Provider.self, factory: { r -> BO.Provider in
                        return BO.MockProvider.MockAppInfoForceUpdate
                    }).inObjectScope(.container)
                    object.transform()
                    expect( view.isPromptForceUpdateDialog ).toEventually(equal( true ))
                }
            }
            context("routing") {
                context("for new user") {
                    beforeEach {
                        DI.container.register(LoginSessionRepositoryType.self, factory: { r -> LoginSessionRepositoryType in
                            let ret = MockNewUserSessionLoginSessionRepository()
                            return ret
                        }).inObjectScope(.container)
                    }
                }
                context("for logon user") {
                    beforeEach {
                        DI.container.register(LoginSessionRepositoryType.self, factory: { r -> LoginSessionRepositoryType in
                            let ret = MockLogonSessionLoginSessionRepository()
                            return ret
                        }).inObjectScope(.container)
                    }
                    it("to login if revalidation fail") {
                        DI.container.register(AuthServiceType.self, factory: { r -> AuthServiceType in
                            return MockRevalidationFailAuthService()
                        }).inObjectScope(.container)
                        
                        object.transform()
                        expect( view.isRouteToLogin ).toEventually(equal( true ))
                    }
                    it("to activation if revalidation success and not activated") {
                        DI.container.register(UserDefaults.self, factory: { r -> UserDefaults in
                            return UserDefaults.NotActivated
                        }).inObjectScope(.container)
                        
                        object.transform()
                        
                        expect( view.isRouteToActivation ).toEventually(equal( false ))
                    }
                    it("to dashboard if revalidation success and activated") {
                        DI.container.register(UserDefaults.self, factory: { r -> UserDefaults in
                            return UserDefaults.Activated
                        }).inObjectScope(.container)
                        
                        object.transform()
                        expect( view.isRouteToDashboard ).toEventually(equal( true ))
                    }
                }
            }
        }
    }
}

