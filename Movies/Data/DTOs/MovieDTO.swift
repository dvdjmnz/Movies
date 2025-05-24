//
//  MovieDTO.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

struct MovieDTO: Codable {
    let id: Int
    let title: String
    let voteAverage: Double
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}

extension MovieDTO: DomainConvertibleEntity {
    func toDomain() -> Movie {
        Movie(
            id: id,
            title: title,
            voteAverage: voteAverage,
            posterPath: Constants.Network.tmdbImagesBaseUrl.appending(path: posterPath)
        )
    }
}

