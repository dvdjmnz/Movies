//
//  DefaultGenresRepository.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

struct DefaultGenresRepository: GenresRepository {
    let tmdbDataSource: TmdbDataSource
    
    func getMovieGenres() -> Observable<[Genre]> {
        tmdbDataSource.getMovieGenres().map { $0.toDomain() }
    }
    
    func getTvShowsGenres() -> Observable<[Genre]> {
        tmdbDataSource.getTvShowsGenres().map { $0.toDomain() }
    }
}
