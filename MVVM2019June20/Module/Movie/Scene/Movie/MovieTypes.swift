//
//  MovieTypes.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 25/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

protocol MovieViewType: BaseViewType {
    var intent: MovieIntent! { set get }
}

typealias MovieViewControllerType = UIViewController & MovieViewType
