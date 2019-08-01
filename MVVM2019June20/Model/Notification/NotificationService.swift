//
//  NotificationService.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NotificationService {
    fileprivate let didFailToRegisterForRemoteNotificationsWithError = PublishRelay<Error>()
    fileprivate let didRegisterForRemoteNotificationsWithDeviceToken = PublishRelay<Data>()
    fileprivate let didReceiveRemoteNotification = PublishRelay<[AnyHashable : Any]>()
    
    var apnsToken: String? = nil
    
    func registerRemoteNotification() -> Observable<Data> {
        return Observable.create({ observer -> Disposable in
            let success = self.didRegisterForRemoteNotificationsWithDeviceToken.subscribe(onNext: { data in
                observer.onNext(data)
                observer.onCompleted()
            })
            let fail = self.didFailToRegisterForRemoteNotificationsWithError.subscribe(onNext: { error in
                observer.onError(error)
            })
            return Disposables.create([success, fail])
        })
            .do(onNext: { data in
                self.apnsToken = data.string(encoding: .utf8)
            })
    }
    
    
    func subscribeContentProvider() -> Observable<Void> {
        let api = Observable.just(()).delay(2.0, scheduler: MainScheduler.instance)
        return api
    }
    
    func unsubscribeContentProvider(catchErrorJustNext: Bool = true) -> Observable<Void> {
        let api = Observable.just(()).delay(2.0, scheduler: MainScheduler.instance)
        return api.catchError({ error -> Observable<()> in
            if catchErrorJustNext {
                return .just(())
            } else {
                return .error(error)
            }
        })
    }
    
    func remoteNotification() -> Observable<NotificationPayLoad> {
        return .empty()
    }
}
