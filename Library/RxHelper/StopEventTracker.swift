//
//  StopEventTracker.swift
//  AIAAgent
//
//  Created by Yee Chuan Lee on 17/01/2019.
//  Copyright © 2019 lee yee chuan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class StopEventTracker: SharedSequenceConvertibleType {
    typealias SharingStrategy = DriverSharingStrategy
    private let _subject = PublishSubject<()>()
    
    func trackStopEvent<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
        return source.asObservable().do(onError: onError, onCompleted: onCompleted)
    }
    
    func asSharedSequence() -> SharedSequence<SharingStrategy, ()> {
        return _subject.asObservable().asDriverOnErrorJustComplete()
    }
    
    func asObservable() -> Observable<()> {
        return _subject.asObservable()
    }
    
    private func onCompleted() {
        _subject.onNext(())
    }
    
    private func onError(_ error: Error) {
        _subject.onNext(())
    }
    
    deinit {
        _subject.onCompleted()
    }
}

extension ObservableConvertibleType {
    func trackStopEvent(_ stopEventTracker: StopEventTracker) -> Observable<Element> {
        return stopEventTracker.trackStopEvent(from: self)
    }
}
