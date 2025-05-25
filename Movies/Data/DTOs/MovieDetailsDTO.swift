//
//  MovieDetailsDTO.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

struct MovieDetailsDTO: Codable {
    let id: Int
    let revenue: Int
    let budget: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case revenue = "revenue"
        case budget = "budget"
    }
}

extension MovieDetailsDTO: DomainConvertibleEntity {
    func toDomain() -> MovieDetails {
        MovieDetails(
            id: id,
            revenue: revenue.toUSDCurrencyCompact(),
            budget: budget.toUSDCurrencyCompact()
        )
    }
}
