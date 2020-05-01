//
//  DisposableEventHelper.swift
//  MVVM2019June20
//
//  Created by UF-Jacky.Lee on 17/04/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation

func disposeDisposableEventProperties(object: Any) {
    let mirror = Mirror(reflecting: object)
    for child in mirror.children {
        if var child = child.value as? EventDisposable {
            child.dispose()
        }
    }
}
