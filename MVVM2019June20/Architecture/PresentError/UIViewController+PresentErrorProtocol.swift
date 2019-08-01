//
//  UIViewController+PresentErrorProtocol.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 27/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift

extension UIViewController: PresentErrorProtocol {
    func present(error: Error, completion: @escaping ()->()) {
        let impl = PresentErrorProtocolImpl(base: self)
        return impl.present(error:error, completion: completion)
    }
}


