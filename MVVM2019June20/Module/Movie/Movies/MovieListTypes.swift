//
//  MovieListTypes.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 25/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxDataSources

typealias MovieItem = MovieCardCellViewModel

typealias MovieSection = SectionModel<String, MovieItem>

protocol MovieListViewType: BasePaginationViewType {
    func routeToMovieDetail(intent: MovieIntent)
}


typealias MovieListViewControllerType = UIViewController & MovieListViewType

