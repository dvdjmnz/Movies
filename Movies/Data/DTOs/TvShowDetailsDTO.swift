//
//  TvShowDetailsDTO.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

struct TvShowDetailsDTO: Codable {
    let id: Int
    let lastAirDate: String
    let lastEpisodeToAir: LastEpisode
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
    }
}

extension TvShowDetailsDTO {
    struct LastEpisode: Codable {
        let name: String
    }
}

extension TvShowDetailsDTO: DomainConvertibleEntity {
    func toDomain() -> TvShowDetails {
        TvShowDetails(
            id: id,
            lastAirDate: lastAirDate.toLocalizedDate(),
            lastEpisodeName: lastEpisodeToAir.name
        )
    }
}
