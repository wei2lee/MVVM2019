//
//  LoginNavigationTypes.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 31/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

protocol LoginNavigationViewType {
    var intent: LoginNavigationIntent! { set get }
}

typealias LoginNavigationControllerType = UINavigationController & LoginNavigationViewType
