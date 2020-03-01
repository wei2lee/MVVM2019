//
//  DashboardTypes.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardViewType: BaseViewType {
    func routeToMovieList()
    func routeToLogout()
    func routeToProfile()
    func promptLoginModal()
    func promptLockModal()
}

typealias DashboardViewControllerType = UIViewController & DashboardViewType

