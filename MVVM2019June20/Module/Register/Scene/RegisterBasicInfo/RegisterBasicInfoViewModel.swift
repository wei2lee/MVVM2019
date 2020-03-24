//
//  RegisterBasicInfoViewModel.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 01/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class RegisterBasicInfoViewModel: BaseViewModel {
    //MARK: Input
    let firstName: BehaviorRelay<String?> = .init(value: "")
    let lastName: BehaviorRelay<String?> = .init(value: "")
    let email: BehaviorRelay<String?> = .init(value: "")
    let password: BehaviorRelay<String?> = .init(value: "")
    let confirmPassword: BehaviorRelay<String?> = .init(value: "")
    let firstNameState: BehaviorRelay<ValidationState> = .init(value: .initial)
    let lastNameState: BehaviorRelay<ValidationState> = .init(value: .initial)
    var startNext: Driver<Void> = .never()
    //MARK: Output
    public weak var view: RegisterBasicInfoViewType? = nil

    //MARK: Dependency

    //MARK: State
    let intent: RegisterBasicInfoIntent
    //MARK: initializer
    init(intent: RegisterBasicInfoIntent) {
        self.intent = intent
        super.init()
    }

    //MARK: transform
    override func transform() {
        let isEnabled: Driver<Bool> = Driver.combineLatest(firstNameState.asDriver(), lastNameState.asDriver()) { 
            return $0.isSuccess && $1.isSuccess
        }
        isEnabled.drive(onNext: {
            print("isEnabled = \($0)")
        })
        
        
        let routeToNext = startNext.do(onNext: {
            _ = self.view!.presentDialog(title: "Register",
                                     message: "Successful!",
                                     action: .close())
                .do(onNext: { _ in
                    self.view!.dismissView()
                }).drive()
        })
        
        //subscribe
        disposeBag.insert(
            routeToNext.drive()
        )
    }
    override func dispose() {
        super.dispose()
    }
   
}
