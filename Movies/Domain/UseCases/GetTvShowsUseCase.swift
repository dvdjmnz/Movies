//
//  GetTvShowsUseCase.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol GetTvShowsUseCase {
    func execute(genre: Int) -> Observable<Page<TvShow>>
}

class DefaultGetTvShowsUseCase {
    let repository: TvShowsRepository
    
    init(repository: TvShowsRepository) {
        self.repository = repository
    }
}

extension DefaultGetTvShowsUseCase: GetTvShowsUseCase {
    func execute(genre: Int) -> Observable<Page<TvShow>> {
        repository.getTvShows(genre: genre)
    }
}
