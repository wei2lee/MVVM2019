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
    //MARK: Model
    typealias PlaceholderForm = (firstName: String, lastName: String)
    //MARK: Input
    let firstName: BehaviorRelay<String?> = .init(value: "")
    let lastName: BehaviorRelay<String?> = .init(value: "")
    let email: BehaviorRelay<String?> = .init(value: "")
    let password: BehaviorRelay<String?> = .init(value: "")
    let confirmPassword: BehaviorRelay<String?> = .init(value: "")
    let firstNameState: BehaviorRelay<ValidationState> = .init(value: .initial)
    let lastNameState: BehaviorRelay<ValidationState> = .init(value: .initial)
    @ViewEvent var startNext: Driver<Void> = .never()
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
        let loadPlaceholderForm = startLoad
            .flatMap(getPlaceholderRegisterForm)
            .do(onNext: updatePlaceholderForm)
        
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
            loadPlaceholderForm.drive(),
            routeToNext.drive()
        )
    }

    fileprivate func updatePlaceholderForm(form: PlaceholderForm) {
        self.firstName.accept(form.firstName)
        self.lastName.accept(form.lastName)
    }
    
    fileprivate func getPlaceholderRegisterForm() -> Driver<PlaceholderForm> {
        return Observable.just(()).delay(.milliseconds(2000), scheduler: MainScheduler.instance).map {
            return (firstName: "Example First Name", lastName: "Example Last Name")
        }
        .trackActivity(activityIndicator)
        .asDriverOnErrorJustSkip()
    }
}
