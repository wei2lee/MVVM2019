//
//  DisposableEvent.swift
//  MVVM2019June20
//
//  Created by UF-Jacky.Lee on 16/04/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol EventDisposable {
    mutating func dispose()
}

@propertyWrapper
struct DisposableEvent<T> : EventDisposable {
    mutating func dispose() {
        event = .never()
    }
    
    var event: Driver<T> = .never()
    public var wrappedValue: Driver<T> {
        mutating get {
            return event
        }
        mutating set {
            event = newValue
        }
    }
    
    init(wrappedValue: Driver<T>) {
        self.event = wrappedValue
    }
}
