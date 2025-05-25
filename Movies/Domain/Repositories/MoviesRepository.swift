//
//  MoviesRepository.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol MoviesRepository {
    func getMovies(genre: Int, page: Int) -> Observable<Page<Movie>>
    func getMovieDetails(movieId: Int) -> Observable<MovieDetails>
}
