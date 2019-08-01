//
//  DropDownViewType.swift
//  AIAAgent
//
//  Created by Yee Chuan Lee on 13/11/2018.
//  Copyright © 2018 lee yee chuan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SingleSelectionViewType : class, ReactiveCompatible {
    var selectedIndex:Int? { set get }
    var selectedIndexSubject: PublishRelay<Int?> { get }
    var options: [String] { set get }
}

extension Reactive where Base: SingleSelectionViewType {
    var selectedIndex: ControlProperty<Int?> {
        let source = Observable<Int?>.create { [weak control = self.base] observer in
            MainScheduler.ensureExecutingOnScheduler()
            guard let control = control else {
                observer.on(.completed)
                return Disposables.create()
            }
            let d = control.selectedIndexSubject.startWith(control.selectedIndex).bind(to: observer)
            return Disposables.create([d])
        }
        let binding = Binder(self.base) { (dropDownView, value:Int?) in
            dropDownView.selectedIndex = value
        }
        return ControlProperty(values: source, valueSink: binding)
    }
    var options: Binder<[String]> {
        return Binder<[String]>(self.base) { (target:Base, options:[String]) -> () in
            target.options = options
        }
    }
}
