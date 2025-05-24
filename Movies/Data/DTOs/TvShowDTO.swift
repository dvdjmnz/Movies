//
//  TvShowDTO.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

struct TvShowDTO: Codable {
    let id: Int
    let name: String
    let voteAverage: Double
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}

extension TvShowDTO: DomainConvertibleEntity {
    func toDomain() -> TvShow {
        TvShow(
            id: id,
            name: name,
            voteAverage: voteAverage,
            posterPath: Constants.Network.tmdbImagesBaseUrl.appending(path: posterPath)
        )
    }
}
