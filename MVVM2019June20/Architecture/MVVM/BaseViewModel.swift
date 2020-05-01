//
//  BaseViewModel.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 22/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel: BaseViewModelType, ViewModelType, ErrorHandlingViewModelType, ReactiveCompatible {
    //MARK: Input
    @ViewEvent public var startLoad: Driver<Void> = .never()
    @ViewEvent public var startResume: Driver<Void> = .never()
    @ViewEvent public var startReload: Driver<Void> = .never()
    @ViewEvent public var startLoadMore: Driver<Void> = .never()
    @ViewEvent public var startExit: Driver<Void> = .never()
    //MARK: Output
    @PresentationBinding public var showLoading: Driver<Bool> = .never()
    public var showError: ErrorHandlingOutput = .none()
    @PresentationBinding public var contentReady: Driver<Bool> = .never()
    @PresentationBinding public var exitWithResult: Driver<DismissResult> = .never()
    //MARK: Dependency
    @Injected public var buildConfig: BuildConfigType
    @Injected public var dateProvider: DateProviderType
    @Injected public var Defaults: UserDefaults
    //MARK: State
    let activityIndicator = ActivityIndicator()
    let errorTracker = ErrorTracker()
    let stopEventTracker = StopEventTracker()
    //MARK: transform
    func transform() {
        showLoading = activityIndicator.asDriver()
    }
    func subscribe() {
        
    }
    func dispose() {
        let retainCount = CFGetRetainCount(self)
        //Input
        disposeDisposableEventProperties(object: self)
        //DisposeBag
        disposeBag = DisposeBag()
        let retainCount2 = CFGetRetainCount(self)
        Log.debug("\(self) \(retainCount)->\(retainCount2)", userInfo: LogTag.clearup.dictionary)
    }
    deinit {
        Log.debug("\(self)", userInfo: LogTag.clearup.dictionary)
    }
    //MARK: Helper
}
