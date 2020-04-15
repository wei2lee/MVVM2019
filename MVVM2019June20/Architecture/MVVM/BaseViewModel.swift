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
    public var startLoad: Driver<Void> = .never()
    public var startResume: Driver<Void> = .never()
    public var startReload: Driver<Void> = .never()
    public var startLoadMore: Driver<Void> = .never()
    public var startExit: Driver<Void> = .never()
    //MARK: Output
    public var showLoading: Driver<Bool> = .never()
    public var showError: ErrorHandlingOutput = .none()
    public var contentReady: Driver<Bool> = .never()
    public var exitWithResult: Driver<DismissResult> = .never()
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
        //Log.debug("\(self)", userInfo: LogTag.clearup.dictionary)
        //Input
        startLoad = .never()
        startResume = .never()
        startReload = .never()
        startExit = .never()
        //Output
        showLoading = .never()
        showError = .none()
        contentReady = .never()
        exitWithResult = .never()
        //DisposeBag
        disposeBag = DisposeBag()
    }
    deinit {
        //Log.debug("\(self)", userInfo: LogTag.clearup.dictionary)
    }
    //MARK: Helper
}
