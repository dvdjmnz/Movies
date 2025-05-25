//
//  Page.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

struct Page<T> {
    let page: Int
    let totalPages: Int
    let results: [T]
    
    var hasNextPage: Bool { page < totalPages }
}
