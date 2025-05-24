//
//  GetMovieDetailsUseCase.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol GetMovieDetailsUseCase {
    func execute(movieId: Int) -> Observable<MovieDetails>
}

class DefaultGetMovieDetailsUseCase {
    let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
}

extension DefaultGetMovieDetailsUseCase: GetMovieDetailsUseCase {
    func execute(movieId: Int) -> Observable<MovieDetails> {
        repository.getMovieDetails(movieId: movieId)
    }
}
