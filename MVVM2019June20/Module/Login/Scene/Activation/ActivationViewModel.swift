//
//  ActivationViewModel.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 21/06/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift
import SwiftDate

final class ActivationViewModel: BaseViewModel {
    fileprivate typealias RequestActivationTimerData = (text: String, isEnabled: Bool)
    fileprivate static let requestActivationExpire: DateComponents = 180.seconds
    fileprivate static let activiationCodeCount: Int = 6
    fileprivate static let nonNumberRegex = try! NSRegularExpression(pattern:"[^\\d]", options: .caseInsensitive)
    //MARK: Input
    public let activationCode = BehaviorRelay<String?>(value: nil)
    @ViewEvent public var startRequestActivationCode: Driver<Void> = .never()
    @ViewEvent public var startSubmit: Driver<Void> = .never()
    //MARK: Output
    public let requestActivationStatusText = BehaviorRelay<String?>(value: nil)
    public let enableRequestActivate = BehaviorRelay<Bool>(value: false)
    public weak var view: ActivationViewType? = nil
    //MARK: Dependency
    @Injected fileprivate var authService: AuthServiceType
    //MARK: State
    fileprivate var requestActivationCodeOnStartCompleted: Bool = false
    fileprivate var lastRequestActivationDate: Date?
    //MARK: transform
    func dosomething() { }
    override func transform() {
        super.transform()
        
        let requestActivationCodeOnStart = startLoad
            .flatMapLatest{
                self.validateRequestActivate()
                    .flatMapLatest{ self.requestActivationCode() }
                    .do(onCompleted: { self.requestActivationCodeOnStartCompleted = true })
            }
            

        let startRequestActivationTimer = startLoad
            .flatMap { _ in
            Observable<Int>.interval(.milliseconds(500), scheduler: MainScheduler.instance)
                .startWith(0)
                .asDriverOnErrorJustComplete()
        }
        
        let requestActivationCodeOnSubmit = startRequestActivationCode
            .flatMapLatest{
                self.validateRequestActivate()
                    .flatMapLatest{ self.requestActivationCode() }
            }
            
        
        let requestActivationModel: Driver<BO.ResponseRequestActivation> = Driver.merge(requestActivationCodeOnStart,
                                                                                        requestActivationCodeOnSubmit)
        
        let startRequestActivationTimerData = startRequestActivationTimer
            .asVoid()
            .map(self.createRequestActivationTimerData)
        
        let requestActivationStatusText = startRequestActivationTimerData.map { $0.text }
        
        let enableRequestActivate = startRequestActivationTimerData.map { $0.isEnabled }
        
        let doActivate = startSubmit
        .flatMapLatest(self.validateActivation)
        .withLatestFrom(requestActivationModel) { (self.activationCode.value.orEmpty, $1) }
        .flatMapLatest(self.activate)
        .asVoid()
        .do(onNext: self.saveStateOnActivateSuccess )
        .do(onNext: { self.view?.routeToDashboard() })
        
        let doLogout = startExit
            .flatMapLatest { self.logout() }
            .do(onNext: { self.view?.dismissToLogin() })
        
        let convertForm = self.convertForm()
        
        _ = self.transformErrorHandling(input: ErrorHandlingInput(view: view, errorTracker: errorTracker))
        //MARK: subscribe
        
        disposeBag.insert(
            requestActivationCodeOnStart.drive(),
            requestActivationCodeOnSubmit.drive(),
            requestActivationStatusText.drive(self.requestActivationStatusText),
            enableRequestActivate.drive(self.enableRequestActivate),
            doActivate.drive(),
            convertForm.drive(),
            doLogout.drive()
        )
    }
    
    //MARK: Helper
    fileprivate func convertForm() -> Driver<Void> {
        return activationCode.asDriver().distinctUntilChanged().do(onNext: { string in
            let oldString: String = string.orEmpty
            let newString: String = {
                var ret: String = string.orEmpty
                let regex = type(of: self).nonNumberRegex
                ret = regex.stringByReplacingMatches(in: ret,
                                                       options: [],
                                                       range: NSRange(location: 0, length:  ret.count),
                                                       withTemplate: "")
                let maxCount = type(of: self).activiationCodeCount
                ret = String(ret.prefix(maxCount))
                return ret
            }()
            if newString != oldString {
                DispatchQueue.main.async {
                    self.activationCode.accept(newString)
                }
            }
        }).asVoid()
    }
    
    fileprivate func createRequestActivationTimerData() -> RequestActivationTimerData {
        guard requestActivationCodeOnStartCompleted else {
            return (text: "", isEnabled: false)
        }
        if let lastRequestActivationDate: DateInRegion = lastRequestActivationDate?.inLocal {
            let now = EnumRegion.local.now
            let passedInterval: TimeInterval = now.timeIntervalSince1970 - lastRequestActivationDate.timeIntervalSince1970
            let expireInterval = type(of: self).requestActivationExpire.timeInterval
            let countDown: TimeInterval = max(0, expireInterval - passedInterval)
            if countDown <= 0 {
                return (text: "", isEnabled: true)
            } else {
                let countDownText = convertTimeIntervalToRemainTime(countDown)
                let text = String(format: "Request Activation Expire : %@", countDownText)
                return (text: text, isEnabled: false)
            }
        } else {
            return (text: "", isEnabled: true)
        }
    }
    
    fileprivate func convertTimeIntervalToRemainTime(_ timerInterval:TimeInterval) -> String {
        let minute = Int(timerInterval / 60)
        let second = Int(timerInterval) % 60
        return String(format:"%02d:%02d", minute, second)
    }
    
    fileprivate func getValidateRequestActivation() -> [NSError] {
        let now = EnumRegion.local.now
        if let lastRequestActivationDate: DateInRegion = lastRequestActivationDate?.inLocal {
            if now - lastRequestActivationDate > type(of: self).requestActivationExpire.timeInterval {
                return []
            } else {
                return [RequestActivationFormValidationError.requestActivationNotExpired.error]
            }
        }
        return []
    }
    
    fileprivate func validateActivation() -> Driver<Void> {
        func validate() -> [NSError] {
            let string = activationCode.value.orEmpty
            if string.count == 0 {
                return [ActivationFormValidationError.isEmpty.error]
            }
            if string.count < type(of: self).activiationCodeCount {
                return [ActivationFormValidationError.lessThan6Character.error]
            }
            let regex = type(of: self).nonNumberRegex
            let matches = regex.matches(in: string,
                                        options: [],
                                        range: NSRange(location: 0, length:  string.count))
            if matches.count > 0 {
                return [ActivationFormValidationError.containNonDigit.error]
            }
            return []
        }
        return Observable.create { ob in
            if let error = validate().first {
                ob.onError(error)
            } else {
                ob.onNext(())
                ob.onCompleted()
            }
            return Disposables.create()
        }
        .trackError(errorTracker)
        .asDriverOnErrorJustComplete()
    }

    fileprivate func validateRequestActivate() -> Driver<Void> {
        let validate = Observable.just(()).flatMapLatest { _  -> Observable<Void> in
            if let error = self.getValidateRequestActivation().first {
                    return .error(error)
            }
            return .just(())
        }
        return validate
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
    }
    
    fileprivate func requestActivationCode() -> Driver<BO.ResponseRequestActivation> {
        let input = BO.RequestRequestActivation()
        let api = BO.EndPoint.RequestActivation(input: input).request()
        return api
            .do(onNext: { _ in
                self.lastRequestActivationDate = EnumRegion.local.now.date
            })
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .trackActivity(self.activityIndicator)
            .trackError(self.errorTracker)
            .asDriverOnErrorJustComplete()
    }
    
    fileprivate func activate(activationCode: String,
                              requestActiviationModel: BO.ResponseRequestActivation) -> Driver<BO.ResponseVerifyActivation> {
        let input = BO.RequestVerifyActivation()
        input.activationCode = activationCode
        input.sessionId = requestActiviationModel.sessionId
        let api = BO.EndPoint.VerifyActivation(input: input).request()
        return api
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .trackActivity(self.activityIndicator)
            .trackError(self.errorTracker)
            .asDriverOnErrorJustComplete()
    }
    
    fileprivate func saveStateOnActivateSuccess() {
        self.Defaults[.isActivated] = true
    }
    
    fileprivate func logout() -> Driver<Void> {
        return authService.logout(loginSession: .current, catchErrorJustNext: true)
            .trackActivity(activityIndicator)
            .asDriverOnErrorJustComplete()
            .asVoid()
    }
}


