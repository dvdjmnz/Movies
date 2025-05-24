//
//  GetMoviesUseCase.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol GetMoviesUseCase {
    func execute(genre: Int) -> Observable<Page<Movie>>
}

struct DefaultGetMoviesUseCase: GetMoviesUseCase {
    let repository: MoviesRepository

    func execute(genre: Int) -> Observable<Page<Movie>> {
        repository.getMovies(genre: genre)
    }
}
