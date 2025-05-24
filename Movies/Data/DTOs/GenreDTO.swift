//
//  GenreDTO.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

struct GenreDTO: Codable {
    let id: Int
    let name: String
}

extension GenreDTO: DomainConvertibleEntity {
    func toDomain() -> Genre {
        Genre(id: id, name: name)
    }
}
