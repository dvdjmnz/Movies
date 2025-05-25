//
//  MovieDTO.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Foundation

struct MovieDTO: Codable {
    let id: Int
    let title: String
    let voteAverage: Double
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}

extension MovieDTO: DomainConvertibleEntity {
    func toDomain() -> Movie {
        let posterPathUrl: URL? = {
            guard let posterPath else { return nil }
            return Constants.Network.tmdbImagesBaseUrl.appending(path: posterPath)
        }()
        return Movie(
            id: id,
            title: title,
            voteAverage: voteAverage.toStringWithOneDecimal(),
            posterPath: posterPathUrl
        )
    }
}

