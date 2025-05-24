//
//  DomainConvertibleEntity.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Foundation

protocol DomainConvertibleEntity {
    associatedtype DomainEntity
    func toDomain() -> DomainEntity
}

extension Array where Element: DomainConvertibleEntity {
    func toDomain() -> [Element.DomainEntity] {
        map { $0.toDomain() }
    }
}
