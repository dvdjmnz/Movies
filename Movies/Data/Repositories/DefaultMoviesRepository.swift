//
//  DefaultMoviesRepository.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

class DefaultMoviesRepository {
    let tmdbDataSource: TmdbDataSource
    
    init(tmdbDataSource: TmdbDataSource) {
        self.tmdbDataSource = tmdbDataSource
    }
}
    
extension DefaultMoviesRepository: MoviesRepository {
    func getMovies(genre: Int, page: Int) -> Observable<Page<Movie>> {
        tmdbDataSource.getMovies(genre: genre, page: page).map { $0.toDomain() }
    }
    
    func getMovieDetails(movieId: Int) -> Observable<MovieDetails> {
        tmdbDataSource.getMovieDetails(movieId: movieId).map { $0.toDomain() }
    }
}

