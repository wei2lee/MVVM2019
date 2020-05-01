//
//  MovieViewController.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieViewController: BaseViewController<MovieViewModel> {
    var intent: MovieIntent!
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(MovieViewModel.self, argument: intent!)
    }
}
//MARK: <MovieViewControllerType>
extension MovieViewController : MovieViewType {
    
}
