//
//  GetTvShowGenresUseCase.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol GetTvShowGenresUseCase {
    func execute() -> Observable<[Genre]>
}

class DefaultGetTvShowGenresUseCase {
    let repository: GenresRepository
    
    init(repository: GenresRepository) {
        self.repository = repository
    }
}

extension DefaultGetTvShowGenresUseCase: GetTvShowGenresUseCase {
    func execute() -> Observable<[Genre]> {
        repository.getTvShowsGenres()
    }
}
