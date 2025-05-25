//
//  DefaultTvShowsRepository.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

class DefaultTvShowsRepository {
    let tmdbDataSource: TmdbDataSource
    
    init(tmdbDataSource: TmdbDataSource) {
        self.tmdbDataSource = tmdbDataSource
    }
}
    
extension DefaultTvShowsRepository: TvShowsRepository {
    func getTvShows(genre: Int, page: Int) -> Observable<Page<TvShow>> {
        tmdbDataSource.getTvShows(genre: genre, page: page).map { $0.toDomain() }
    }
    
    func getTvShowDetails(tvShowId: Int) -> Observable<TvShowDetails> {
        tmdbDataSource.getTvShowDetails(tvShowId: tvShowId).map { $0.toDomain() }
    }
}
