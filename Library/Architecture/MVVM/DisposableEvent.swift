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

@propertyWrapper
class DisposableEvent<T> : Disposable {
    func dispose() {
        event = .never()
    }
    
    var event: Driver<T> = .never()
    public var wrappedValue: Driver<T> {
        get {
            return event
        }
        set {
            event = newValue
        }
    }
    
    init(wrappedValue: Driver<T>) {
        self.event = wrappedValue
    }
}

func disposeDisposableEventProperties(object: Any) {
    let mirror = Mirror(reflecting: object)
    for child in mirror.children {
        if let child = child.value as? Disposable {
            child.dispose()
        }
    }
}
