//
//  Movie.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let voteAverage: String
    let posterPath: URL?
}
