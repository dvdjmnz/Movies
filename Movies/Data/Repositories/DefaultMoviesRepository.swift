//
//  DefaultMoviesRepository.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

struct DefaultMoviesRepository: MoviesRepository {
    let tmdbDataSource: TmdbDataSource
    
    func getMovies(genre: Int) -> Observable<Page<Movie>> {
        tmdbDataSource.getMovies(genre: genre).map { $0.toDomain() }
    }
    
    func getMovieDetails(movieId: Int) -> Observable<MovieDetails> {
        tmdbDataSource.getMovieDetails(movieId: movieId).map { $0.toDomain() }
    }
}

