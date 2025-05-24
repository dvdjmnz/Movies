//
//  MovieDetailsDTO.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

struct MovieDetailsDTO: Codable {
    let id: Int
    let title: String
    let voteAverage: Double
    let posterPath: String
    let revenue: Int
    let budget: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case revenue = "revenue"
        case budget = "budget"
    }
}

extension MovieDetailsDTO: DomainConvertibleEntity {
    func toDomain() -> MovieDetails {
        MovieDetails(
            id: id,
            title: title,
            voteAverage: voteAverage,
            posterPath: Constants.Network.tmdbImagesBaseUrl.appending(path: posterPath),
            revenue: revenue,
            budget: budget
        )
    }
}
