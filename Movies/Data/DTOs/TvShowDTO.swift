//
//  TvShowDTO.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Foundation

struct TvShowDTO: Codable {
    let id: Int
    let name: String
    let voteAverage: Double
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}

extension TvShowDTO: DomainConvertibleEntity {
    func toDomain() -> TvShow {
        let posterPathUrl: URL? = {
            guard let posterPath else { return nil }
            return NetworkConstants.tmdbImagesBaseUrl.appending(path: posterPath)
        }()
        return TvShow(
            id: id,
            name: name,
            voteAverage: voteAverage.toStringWithOneDecimal(),
            posterPath: posterPathUrl
        )
    }
}
