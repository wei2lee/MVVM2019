//
//  ShowLoginSessionExpireViewType.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 04/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol ShowLoginSessionExpireViewType {
    func showLoginSessionExpire(error:NSError) -> Driver<Void>
}
