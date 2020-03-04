//
//  SegmentedControlRow.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 02/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import UIKit
import NibDesignable
import RxSwift
import RxCocoa

class SegmentedControlRow: NibDesignable, RowType, Validatable {
    //IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var errorContainerView: UIView!
    @IBOutlet var errorMessageLabel: UILabel!
    //State
    var value: Int? {
        set {
            update()
        }
        get {
            return segmentedControl.selectedSegmentIndex
        }
    }
    
    var validationState: ValidationState = .initial
    
    let onValidationStateChanged: PublishRelay<ValidationState> = .init()
    
    var validateClosure: ((Int?) -> ValidationState) = {_ in
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
        segmentedControl.selectedSegmentIndex = value ?? UISegmentedControl.noSegment
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

extension Reactive where Base : SegmentedControlRow {
    var value: ControlProperty<Int?> {
        let values = self.base.segmentedControl.rx.value
            .asObservable()
            .map({ [weak base] (_) -> Int? in
                return base?.value ?? UISegmentedControl.noSegment
            })
            .startWith(self.base.value)
        
        let valueSink = AnyObserver<Int?>.init(eventHandler: { [weak base] event in
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
