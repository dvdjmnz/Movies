//
//  PageDTO.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

struct PageDTO<T>: Codable where T: Codable, T: DomainConvertibleEntity {
    let page: Int
    let totalPages: Int
    let results: [T]
    
    enum CodingKeys: String, CodingKey {
         case page
         case totalPages = "total_pages"
         case results
     }
    
    func toDomain() -> Page<T.DomainEntity> {
        Page(
            page: page,
            totalPages: totalPages,
            results: results.toDomain()
        )
    }
}
