//
//  DropDownViewModelType.swift
//  AIAAgent
//
//  Created by Yee Chuan Lee on 13/11/2018.
//  Copyright © 2018 lee yee chuan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SingleSelectionViewModelType : ReactiveCompatible {
    associatedtype T
    associatedtype V : SingleSelectionViewType
    var view:V? { set get }
    var optionTextMapper: ((T)->String)? { set get }
    var optionComparer:((T?,T?)->Bool)? { set get }
    func mapOptionText(option:T)->String
    var optionTexts: [String] { get }
    var options:[T] { set get }
    var selectedIndex:Int? { set get }
    var selectedOption: T? { get }
}
typealias DropDownViewModelType = SingleSelectionViewModelType

extension Reactive where Base : SingleSelectionViewModelType {
    var selectedIndex: ControlProperty<Int?> {
        if let view = base.view {
            return view.rx.selectedIndex
        } else {
            return ControlProperty<Int?>(values: Observable.empty(), valueSink: PublishSubject<Int?>())
        }
    }
    var selectedOption: Driver<Base.T?> {
        return selectedIndex.asDriver().map { _ in self.base.selectedOption }
    }
    var dropDownDidSelectedDriver: Driver<Int?> {
        return selectedIndex.asDriver()
    }
    
    var dropDownDidSelectedOptionDriver: Driver<Base.T?> {
        return selectedOption
    }
}
