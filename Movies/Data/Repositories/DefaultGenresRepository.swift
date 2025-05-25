//
//  DefaultGenresRepository.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

class DefaultGenresRepository {
    let tmdbDataSource: TmdbDataSource
    
    init(tmdbDataSource: TmdbDataSource) {
        self.tmdbDataSource = tmdbDataSource
    }
}

extension DefaultGenresRepository: GenresRepository {
    func getMovieGenres() -> Observable<[Genre]> {
        tmdbDataSource.getMovieGenres().map { $0.toDomain() }
    }
    
    func getTvShowsGenres() -> Observable<[Genre]> {
        tmdbDataSource.getTvShowsGenres().map { $0.toDomain() }
    }
}
