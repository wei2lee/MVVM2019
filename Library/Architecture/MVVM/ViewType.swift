//
//  ViewType.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 22/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewType {
    associatedtype VM: ViewModelType
    var viewModel: VM! { set get }
}
