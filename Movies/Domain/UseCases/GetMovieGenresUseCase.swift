//
//  GetMovieGenresUseCase.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol GetMovieGenresUseCase {
    func execute() -> Observable<[Genre]>
}

class DefaultGetMovieGenresUseCase {
    let repository: GenresRepository
    
    init(repository: GenresRepository) {
        self.repository = repository
    }
}

extension DefaultGetMovieGenresUseCase: GetMovieGenresUseCase {
    func execute() -> Observable<[Genre]> {
        repository.getMovieGenres()
    }
}
