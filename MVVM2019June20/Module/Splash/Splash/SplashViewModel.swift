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
            .do(onNext: loginRoute)
        
        //subscribe
        disposeBag.insert(
            routeTo.drive()
        )
    }
    override func dispose() {
        super.dispose()
    }
    //MARK: Helper
    fileprivate func getAppInfo() -> Driver<BO.ResponseAppInfo> {
        return appInfo()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .observeOn(MainScheduler.instance)
            .retryWhen(self.retryWhen)
            .trackActivity(activityIndicator)
            .asDriverOnErrorJustComplete()
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
    
    fileprivate func loginRoute() {
        if self.Defaults[.isActivated] == false {
            view?.routeToActivation()
        } else {
            view?.routeToDashboard()
        }
    }
    
    fileprivate func appInfo() -> Observable<BO.ResponseAppInfo> {
        let input = BO.RequestAppInfo()
        input.platform = .ios
        input.version = SwifterSwift.appVersion
        let api = BO.EndPoint.AppInfo(input: input).request(provider: provider)
        return api
    }
}
