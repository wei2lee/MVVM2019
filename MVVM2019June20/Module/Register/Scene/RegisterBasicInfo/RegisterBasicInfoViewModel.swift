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
        let routeToNext = startNext.do(onNext: { self.view?.routeToNext() })
        
        //subscribe
        disposeBag.insert(
            routeToNext.drive()
        )
    }
    override func dispose() {
        super.dispose()
    }
   
}
