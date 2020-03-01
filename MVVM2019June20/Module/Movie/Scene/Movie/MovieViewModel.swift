//
//  MovieViewModel.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa

class MovieViewModel: BaseViewModel {
    var intent: MovieIntent
    
    init(intent: MovieIntent) {
        self.intent = intent
        super.init()
    }
}
