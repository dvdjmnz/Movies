//
//  GetMoviesUseCase.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol GetMoviesUseCase {
    func execute(genre: Int, page: Int) -> Observable<Page<Movie>>
}

class DefaultGetMoviesUseCase {
    let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
}

extension DefaultGetMoviesUseCase: GetMoviesUseCase {
    func execute(genre: Int, page: Int) -> Observable<Page<Movie>> {
        repository.getMovies(genre: genre, page: page)
    }
}
