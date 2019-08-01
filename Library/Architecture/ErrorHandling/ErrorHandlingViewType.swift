//
//  ErrorHandlingViewType.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 04/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

protocol ErrorHandlingViewType: ShowLoginSessionExpireViewType, PresentErrorProtocol {
    func exitToLogin()
}
