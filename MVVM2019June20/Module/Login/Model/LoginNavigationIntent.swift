//
//  LoginNavigationIntent.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 01/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation

struct LoginNavigationIntent {
    let isModal: Bool
    let initialView: EnumLoginNavigationView
    let enableDismiss: Bool
}