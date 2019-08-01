//
//  DI+Modules.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension DI : DIRegistor {
    static func register() {
        Constant.register()
        Model.register()
        View.register()
        ViewModel.register()
    }
}
