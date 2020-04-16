//
//  SplashViewModel.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 02/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class SplashViewModel: BaseViewModel {
    //MARK: Input

    //MARK: Output
    public weak var view: SplashViewType? = nil
    //MARK: Dependency
    @Injected fileprivate var provider: BO.Provider
    @Injected fileprivate var authService: AuthServiceType
    //MARK: State
    //MARK: initializer
    override init() {
        super.init()
    }
    //MARK: transform
    override func transform() {
        super.transform()
        
        let start = startLoad
            .flatMap(getAppInfo)
        
        let routeTo = start.asVoid()
            //authorize function can be either just
            //api call to verify the token,
            //or screens to enter fingerprint/pincode+verifying the token
            .flatMap(authorize)
            .do(onNext: loginRoute)
        
        //subscribe
        disposeBag.insert(
            routeTo.drive()
        )
    }

    //MARK: Helper
    fileprivate func getAppInfo() -> Driver<BO.ResponseAppInfo> {
        let input = BO.RequestAppInfo()
        input.platform = .ios
        input.version = SwifterSwift.appVersion
        let api = BO.EndPoint.AppInfo(input: input).request(provider: provider)
        return api
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .observeOn(MainScheduler.instance)
            .retryWhen(self.retryWhen)
            .trackActivity(activityIndicator)
            .asDriverOnErrorJustComplete()
    }
    
    fileprivate func authorize() -> Driver<Event<Void>> {
        if let session = LoginSession.current {
            return authService.revalidate(loginSession: session, catchErrorJustNext: false)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
                .observeOn(MainScheduler.instance)
                .trackActivity(activityIndicator)
                .materialize()
                .asDriverOnErrorJustComplete()
        } else {
            return Observable<Void>.just(())
                .materialize()
                .asDriverOnErrorJustComplete()
        }
    }
    
    fileprivate func retryWhen(errors: Observable<Error>) -> Observable<Void> {
        return errors.flatMapLatest { error -> Observable<Void> in
            if error as NSError == NetworkError.noInternetConnection.error {
                return self.view!.promptNoInternetConnectionRetryDialog()
                    .asObservable()
            } else {
                return self.view!.promptRetryDialog()
                    .asObservable()
            }
        }.asVoid()
    }
    
    fileprivate func loginRoute(revalidateResult: Event<()>) {
        switch revalidateResult {
        case .next:
            if LoginSession.current != nil {
                if self.Defaults[.isActivated] == false {
                    view?.routeToActivation()
                } else {
                    view?.routeToDashboard()
                }
            } else {
                view?.routeToLogin()
            }
        case .error(_):
            view?.routeToLogin()
        case .completed:
            break
        }
    }
}
