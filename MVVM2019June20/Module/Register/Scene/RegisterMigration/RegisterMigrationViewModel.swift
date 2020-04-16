//
//  RegisterMigrationViewModel.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 02/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class RegisterMigrationViewModel: BaseViewModel {
    //MARK: Input

    //MARK: Output
    public weak var view: RegisterMigrationViewType? = nil

    //MARK: Dependency

    //MARK: State
    let intent: RegisterMigrationIntent
    //MARK: initializer
    init(intent: RegisterMigrationIntent) {
        self.intent = intent
        super.init()
    }

    //MARK: transform
    override func transform() {
    }
}

