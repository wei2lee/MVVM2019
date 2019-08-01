//
//  OMDbMovieSearchResult.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension OMDb {
    struct MovieSearchResult : Codable {
        
        let poster : String?
        let title : String?
        let type : String?
        let year : String?
        let imdbID : String?
        
        
        enum CodingKeys: String, CodingKey {
            case poster = "Poster"
            case title = "Title"
            case type = "Type"
            case year = "Year"
            case imdbID = "imdbID"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            poster = try values.decodeIfPresent(String.self, forKey: .poster)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            type = try values.decodeIfPresent(String.self, forKey: .type)
            year = try values.decodeIfPresent(String.self, forKey: .year)
            imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID)
        }
    }
}
