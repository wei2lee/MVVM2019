//
//  RowType.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 02/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RowType {
    associatedtype T : Equatable
    var value: T { set get }
}
