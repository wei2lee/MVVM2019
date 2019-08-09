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

fileprivate class MockSplashView: MockBaseView, SplashViewType {
    
    
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
        return Driver.just(()).delay(.milliseconds(100)) .do(onSubscribed: {
            self.isPromptNoInternetConnectionRetryDialog = true
        })
    }
    var isPromptRetryDialog = false
    func promptRetryDialog() -> Driver<Void> {
        return Driver.just(()).delay(.milliseconds(100)) .do(onSubscribed: {
                    self.isPromptForceUpdateDialog = true
                })
    }
    var isPromptForceUpdateDialog = false
    func promptForceUpdateDialog() -> Driver<Void> {
        return Driver.just(()).delay(.milliseconds(100)) .do(onSubscribed: {
                    self.isPromptForceUpdateDialog = true
                })
    }
    var isPromptJailBrokenDetectedDialog = false
    func promptJailBrokenDetectedDialog() -> Driver<Void> {
        return Driver.just(()).delay(.milliseconds(100)) .do(onSubscribed: {
                    self.isPromptJailBrokenDetectedDialog = true
                })
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
            let ret = MockNewUserLoginSessionRepository()
            return ret
        }).inObjectScope(.container)
    }
}

class SplashViewModelSpec: QuickSpec {
    var retains: [Any] = []
    override func spec() {
        var object: SplashViewModel!
        var view: MockSplashView!
        describe("SplashViewModel") {
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
                it("prompt retry dialog if other error") {
                    DI.container.register(AuthServiceType.self, factory: { r -> AuthServiceType in
                        return MockFailAuthService()
                    }).inObjectScope(.container)
                    
                    object.transform()
                    
                    expect( view.isPromptRetryDialog ).toEventually(equal( false ))
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
                            let ret = MockNewUserLoginSessionRepository()
                            return ret
                        }).inObjectScope(.container)
                    }
                    it("direct to login") {
                        object.transform()
                        expect( view.isRouteToLogin ).toEventually(equal( true ))
                    }
                }
                context("for logon user") {
                    beforeEach {
                        DI.container.register(LoginSessionRepositoryType.self, factory: { r -> LoginSessionRepositoryType in
                            let ret = MockLogonLoginSessionRepository()
                            return ret
                        }).inObjectScope(.container)
                    }
                    it("direct to login if revalidation fail") {
                        DI.container.register(AuthServiceType.self, factory: { r -> AuthServiceType in
                            return MockFailAuthService()
                        }).inObjectScope(.container)
                        
                        object.transform()
                        expect( view.isRouteToLogin ).toEventually(equal( true ))
                    }
                    it("direct to activation if revalidation success and not activated") {
                        DI.container.register(UserDefaults.self, factory: { r -> UserDefaults in
                            return UserDefaults.NotActivated
                        }).inObjectScope(.container)
                        
                        object.transform()
                        
                        expect( view.isRouteToActivation ).toEventually(equal( false ))
                    }
                    it("direct to dashboard if revalidation success and activated") {
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


