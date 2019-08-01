//
//  DropDownViewModel.swift
//  AIAAgent
//
//  Created by Yee Chuan Lee on 13/11/2018.
//  Copyright © 2018 lee yee chuan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class SingleSelectionViewModel<T, V> : SingleSelectionViewModelType where V : SingleSelectionViewType, T : Equatable {
    weak var view: V? = nil
    
    var optionTextMapper: ((T) -> String)? = nil
    
    var optionComparer: ((T?, T?) -> Bool)? = nil
    
    var optionTexts: [String] {
        return options.map(self.mapOptionText)
    }
    func mapOptionText(option:T)->String {
        if let optionTextMapper = optionTextMapper {
            return optionTextMapper(option)
        } else {
            if let c = option as? SelectionOptionConvertible {
                return c.optionText
            } else {
                return String(describing: option).uppercased()
            }
        }
    }
    
    let optionsVariable:BehaviorRelay<[T]> = BehaviorRelay<[T]>(value:[])
    
    var selectedIndex:Int? {
        set { view?.selectedIndex = newValue }
        get { return view?.selectedIndex }
    }
    
    var selectedOption: T? {
        set {
            if let optionComparer = optionComparer {
                selectedIndex = options.firstIndex(where: { optionComparer($0, newValue) })
            } else {
                selectedIndex = options.firstIndex(where: { $0 == newValue })
            }
        }
        get {
            if let selectedIndex = selectedIndex, 0 <= selectedIndex, selectedIndex < options.count {
                return options[selectedIndex]
            } else {
                return nil
            }
        }
    }
    
    var options:[T] {
        set {
            optionsVariable.accept(newValue)
            view?.options = optionTexts
        }
        get {
            return optionsVariable.value
        }
    }
    init(view: V?) {
        self.view = view
    }
}
