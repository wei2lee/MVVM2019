//
//  RegisterBasicInfoViewTypes.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 01/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol RegisterBasicInfoViewType: BaseViewType {
    var intent: RegisterBasicInfoIntent! { set get }
    
    func routeToNext()
    
    func dismissView()
}

typealias RegisterBasicInfoViewControllerType = UIViewController & RegisterBasicInfoViewType

