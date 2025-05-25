//
//  Constants.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Foundation

enum Constants {
    enum Network {
        static let tmdbApiKey = ""
        
        static let timeout: Int = 30

        static var tmdbApiBaseUrl: URL {
            URL(string: "https://api.themoviedb.org/3")!
        }
        
        static var tmdbImagesBaseUrl: URL {
            URL(string: "https://image.tmdb.org/t/p/w500")!
        }
        
        enum Headers {
            static let authorization = "Authorization"
            static let accept = "Accept"
            static let json = "application/json"
        }

        enum Params {
            static let genres = "with_genres"
            static let page = "page"
        }
    }
}
