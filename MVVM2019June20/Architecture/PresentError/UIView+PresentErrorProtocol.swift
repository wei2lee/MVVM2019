//
//  UIView+PresentErrorProtocol.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 04/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIView: PresentErrorProtocol {
    func present(error: Error, completion: @escaping ()->()) {
        self.parentViewController?.present(error:error, completion: completion)
    }
}


