//
//  GetTvShowDetailsUseCase.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol GetTvShowDetailsUseCase {
    func execute(tvShowId: Int) -> Observable<TvShowDetails>
}

class DefaultGetTvShowDetailsUseCase {
    let repository: TvShowsRepository
    
    init(repository: TvShowsRepository) {
        self.repository = repository
    }
}

extension DefaultGetTvShowDetailsUseCase: GetTvShowDetailsUseCase {
    func execute(tvShowId: Int) -> Observable<TvShowDetails> {
        repository.getTvShowDetails(tvShowId: tvShowId)
    }
}
