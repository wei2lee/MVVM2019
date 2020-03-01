//
//  MovieCardCellViewModel.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 02/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

struct MovieCardCellViewModel {
    //Presentation - Poster
    var posterImageURL: URL?
    //Presentation - Content - Header
    var headerTitleText: String?
    var headerSubTitleText: String?
    var headerTagText: String?
    //Presentation - Content - Body
    var bodyText: NSAttributedString?
    //State
    var movieSearchResult: OMDb.MovieSearchResult?
    //Initializer
    init() { }
}
