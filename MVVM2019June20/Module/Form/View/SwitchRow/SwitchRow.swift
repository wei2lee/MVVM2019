//
//  SwitchRow.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 02/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import UIKit
import NibDesignable
import RxSwift
import RxCocoa

class SwitchRow: NibDesignable, RowType, Validatable {
    //IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var switchControl: UISwitch!
    @IBOutlet var errorContainerView: UIView!
    @IBOutlet var errorMessageLabel: UILabel!
    //State
    var value: Bool {
        set {
            update()
        }
        get {
            return switchControl.isOn
        }
    }
    
    var validationState: ValidationState = .initial
    
    let onValidationStateChanged: PublishRelay<ValidationState> = .init()
    
    var validateClosure: ((Bool) -> ValidationState) = {_ in
        return .initial
    }
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    //initializer
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        _ = self.rx.value.asDriver().drive(onNext: { [weak self]v in
            guard let self = self else { return }
            self.validationState = self.validateClosure(v)
            self.onValidationStateChanged.accept(self.validationState)
        })
    }
    //helper
    func validate() {
        self.validationState = self.validateClosure(value)
        self.onValidationStateChanged.accept(self.validationState)
    }
    func update(animated: Bool = true) {
        switchControl.setOn(self.value, animated: animated)
        switch self.validationState {
        case .initial:
            self.errorMessageLabel.text = ""
            self.errorContainerView.isHidden = true
        case .success:
            self.errorMessageLabel.text = ""
            self.errorContainerView.isHidden = true
        case .failure(let error):
            self.errorMessageLabel.text = error.localizedDescription
            self.errorContainerView.isHidden = false
        }
    }
}

extension Reactive where Base : SwitchRow {
    var value: ControlProperty<Bool> {
        let values = self.base.switchControl.rx.value
            .asObservable()
            .map({ [weak base] (_) -> Bool in
                return base?.value ?? false
            })
            .startWith(self.base.value )
        
        let valueSink = AnyObserver<Bool>.init(eventHandler: { [weak base] event in
            switch event {
            case .next(let value):
                base?.value = value
            default:
                break
            }
        })
        return ControlProperty(values: values, valueSink: valueSink)
    }
    
    var validationState: ControlProperty<ValidationState> {
        let values = self.base.onValidationStateChanged
            .asObservable()
            .map({ [weak base] (_) -> ValidationState in
                return base?.validationState ?? .initial
            })
            .startWith(self.base.validationState)
        
        let valueSink = AnyObserver<ValidationState>.init(eventHandler: { [weak base] event in
            switch event {
            case .next(let value):
                base?.validationState = value
            default:
                break
            }
        })
        return ControlProperty(values: values, valueSink: valueSink)
    }
}
