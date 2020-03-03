//
//  ValidationState.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 02/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation

enum ValidationState {
    case initial
    case success
    case failure(error: NSError)
    
    init(error: NSError?) {
        if let e = error {
            self = .failure(error: e)
        } else {
            self = .success
        }
    }
    
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}


