//
//  TextRow.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 02/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import UIKit
import NibDesignable
import RxSwift
import RxCocoa

class TextRow: NibDesignable, RowType, Validatable {
    //IBOutlets
    @IBOutlet var textField: UITextField!
    @IBOutlet var errorContainerView: UIView!
    @IBOutlet var errorMessageLabel: UILabel!
    //State
    fileprivate var _value: String?
    var value: String? {
        set {
            _value = newValue
            update()
        }
        get {
            return _value
        }
    }
    
    var validationState: ValidationState = .initial {
        didSet {
            update()
        }
    }
    
    let onValidationStateChanged: PublishRelay<ValidationState> = .init()

    var validateClosure: ((String?) -> NSError?) = {_ in
        return nil
    }
    
    var titleText: String? {
        didSet {
            textField.placeholder = titleText
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
            self.validationState = ValidationState(error: self.validateClosure(v) )
            self.onValidationStateChanged.accept(self.validationState)
        })
    }
    //helper
    func validate() {
        self.validationState = ValidationState(error: self.validateClosure( value ) )
        self.onValidationStateChanged.accept(self.validationState)
    }
    
    func update(animated: Bool = true) {
        textField.text = value
        switch self.validationState {
        case .initial:
            self.errorMessageLabel.text = ""
            self.errorContainerView.isHidden = true
            self.setNeedsLayout()
        case .success:
            self.errorMessageLabel.text = ""
            self.errorContainerView.isHidden = true
            self.setNeedsLayout()
        case .failure(let error):
            self.errorMessageLabel.text = error.localizedDescription
            self.errorContainerView.isHidden = false
            self.setNeedsLayout()
        }
    }
}

extension Reactive where Base : TextRow {
    var value: ControlProperty<String?> {
        let values = self.base.textField.rx.controlEvent(.editingChanged)
            .asObservable()
            .map({ [weak base] (_) -> String? in
                return base?.value
            })
            .startWith(self.base.value)
        
        let valueSink = AnyObserver<String?>.init(eventHandler: { [weak base] event in
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
